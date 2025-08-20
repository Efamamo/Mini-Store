import { ConflictException, Injectable, UnauthorizedException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/user/entity/user';
import { Repository } from 'typeorm';
import { SignupDto } from './dtos/signupDto';
import { Address } from 'src/user/entity/address';
import * as bcrypt from 'bcrypt';
import { LoginDto } from './dtos/loginDto';
import { UserService } from 'src/user/user.service';
import { JwtService } from '@nestjs/jwt';
import { JWT_ACCESS_SECRET, JWT_REFRESH_SECRET } from 'src/config/jwt.config';
import { RefreshTokenDto } from './dtos/refreshTokenDto';
import { EmailTakenDto } from '../user/dtos/emailTakenDto';
import { OAuth2Client } from 'google-auth-library';
import axios from 'axios';
import { ProviderSignupDto } from './dtos/providerSignupDto';
import { ProviderSigninDto } from './dtos/providerSigninDto';

@Injectable()
export class AuthService {
    private googleClient: OAuth2Client;

    constructor( 
        private userService: UserService,
        private jwtService: JwtService)
        {
            this.googleClient = new OAuth2Client(
                '130010460553-cftrflh6d6qcb243a6a1m5q4p7f32km0.apps.googleusercontent.com' // your server client id
              );
        }

    async registerUser(signupDto: SignupDto){

        const userExists = await this.userService.findUserByEmail(signupDto.email);
        
        if (userExists){
            throw new ConflictException('User already exists');
        }

        const user = await this.userService.createUser(signupDto);
        const token = await this.signToken(user.id.toString());
        return { "userId": user.id, "accessToken": token.accessToken, "refreshToken": token.refreshToken, "fullName": user.fullName, "email": user.email};

       
    }

    async login(loginDto: LoginDto){
        const user = await this.userService.findUserByEmail(loginDto.email);


        if (!user){
            throw new UnauthorizedException('Invalid credentials');
        }


        const isPasswordValid = await bcrypt.compare(loginDto.password, user.password);
        if (!isPasswordValid){
            throw new UnauthorizedException('Invalid credentials');
        }

        const token = await this.signToken(user.id.toString());
        return { "userId": user.id, "accessToken": token.accessToken, "refreshToken": token.refreshToken, "fullName": user.fullName, "email": user.email};
    }

   

    async signToken(id: string){
        const payload = {sub: id};
        const accessToken = await this.jwtService.signAsync(payload, {secret: JWT_ACCESS_SECRET, expiresIn: '1h'});
        const refreshToken = await this.jwtService.signAsync(payload, {secret: JWT_REFRESH_SECRET, expiresIn: '7d'});

        return { accessToken, refreshToken};
    }

    async refreshToken(refreshTokenDto: RefreshTokenDto){
        const {refreshToken} = refreshTokenDto;
        const decoded = await this.jwtService.verifyAsync(refreshToken, {secret: JWT_REFRESH_SECRET});
        const userId = decoded.sub;
        const user = await this.userService.findUserById(userId);
        if (!user){
            throw new UnauthorizedException('Invalid refresh token');
        }
        const token = await this.signToken(userId.toString());
        return { "userId": user.id, "accessToken": token.accessToken, "refreshToken": token.refreshToken, "fullName": user.fullName, "email": user.email};
    }

   

    async signupWithGoogle(providerSignupDto: ProviderSignupDto) {
        try {
          const ticket = await this.googleClient.verifyIdToken({
            idToken: providerSignupDto.idToken,
            audience: '130010460553-cftrflh6d6qcb243a6a1m5q4p7f32km0.apps.googleusercontent.com',
          });
    
          const payload = ticket.getPayload();
          if (!payload) throw new UnauthorizedException('Invalid Google token');
          
          console.log(payload);
    
          const { email, name } = payload; 
          if (email){
            const userExists = await this.userService.findUserByEmail(email);
            if (userExists){
              throw new ConflictException('User already exists');
            }
            const user = await this.userService.createUser({email, fullName : name as string, password: ''});
            const token = await this.signToken(user.id.toString());
            return { "userId": user.id, "accessToken": token.accessToken, "refreshToken": token.refreshToken, "fullName": user.fullName, "email": user.email};
          }

    
          throw new UnauthorizedException('Invalid Google token');
        } catch (err) {
          throw err;
        }
      }

      async signupWithFacebook(providerSignupDto: ProviderSignupDto) {
        try {
          // Validate token and get user info
          const response = await axios.get(
            `https://graph.facebook.com/me?fields=id,name,email,picture&access_token=${providerSignupDto.idToken}`
          );
    
          const { name, email} = response.data;
          if (email){
            const userExists = await this.userService.findUserByEmail(email);
            if (userExists){
              throw new ConflictException('User already exists');
            }
            const user = await this.userService.createUser({email, fullName : name as string, password: ''});
            const token = await this.signToken(user.id.toString());
            return { "userId": user.id, "accessToken": token.accessToken, "refreshToken": token.refreshToken, "fullName": user.fullName, "email": user.email};
          }
    
          throw new UnauthorizedException('Invalid Facebook token');
        } catch (err) {
          throw err;
        }
      }


      async signinWithGoogle(providerSignupDto: ProviderSigninDto) {
        try {
          const ticket = await this.googleClient.verifyIdToken({
            idToken: providerSignupDto.idToken,
            audience: '130010460553-cftrflh6d6qcb243a6a1m5q4p7f32km0.apps.googleusercontent.com',
          });
    
          const payload = ticket.getPayload();
          if (!payload) throw new UnauthorizedException('Invalid Google token');
          
          console.log(payload);
    
          const { email } = payload; 
          if (email){
            const userExists = await this.userService.findUserByEmail(email);
            if (!userExists){
              throw new UnauthorizedException('User not found');
            }
            const token = await this.signToken(userExists.id.toString());
            return { "userId": userExists.id, "accessToken": token.accessToken, "refreshToken": token.refreshToken, "fullName": userExists.fullName, "email": userExists.email};
          }

    
          throw new UnauthorizedException('Invalid Google token');
        } catch (err) {
          throw err;
        }
      }

      async signinWithFacebook(providerSignupDto: ProviderSigninDto) {
        try {
          // Validate token and get user info
          const response = await axios.get(
            `https://graph.facebook.com/me?fields=id,name,email,picture&access_token=${providerSignupDto.idToken}`
          );
    
          const {  email} = response.data;
          if (email){
            const userExists = await this.userService.findUserByEmail(email);
            if (!userExists){
              throw new UnauthorizedException('User not found');
            }
            const token = await this.signToken(userExists.id.toString());
            return { "userId": userExists.id, "accessToken": token.accessToken, "refreshToken": token.refreshToken, "fullName": userExists.fullName, "email": userExists.email};
          }
    
          throw new UnauthorizedException('Invalid Facebook token');
        } catch (err) {
          throw err;
        }
      }
}
