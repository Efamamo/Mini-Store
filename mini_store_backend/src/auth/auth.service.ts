import { ConflictException, Injectable, UnauthorizedException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/user/entity/user';
import { Repository } from 'typeorm';
import { SignupDto } from './dtos/signupDto';
import { Address } from 'src/user/entity/address';
import * as bcrypt from 'bcrypt';
import { LoginDto } from './dtos/loginDto';
import { UserService } from 'src/user/user.service';
import { UserVerification } from 'src/user/entity/userVerification';
import { EmailService } from 'src/email/email.service';
import { VerifyEmailDto } from './dtos/verifyEmailDto';

@Injectable()
export class AuthService {
    constructor( @InjectRepository(User) private userRepository: Repository<User>,
        @InjectRepository(Address) private addressRepository: Repository<Address>,
        @InjectRepository(UserVerification) private userVerificationRepository: Repository<UserVerification>,
        private userService: UserService,
        private emailService: EmailService){}

    async registerUser(signupDto: SignupDto){

        const userExists = await this.userService.findUserByEmail(signupDto.email);
        
        if (userExists){
            throw new ConflictException('User already exists');
        }

        const hashedPassword = await bcrypt.hash(signupDto.password, 10);


        const user = this.userRepository.create({
            fullName: signupDto.fullName,
            email: signupDto.email,
            password: hashedPassword,
        });
        
        if (signupDto.address){
            const address = this.addressRepository.create(signupDto.address);
            await this.addressRepository.save(address);
            user.address = address;
        }

        const savedUser = await this.userRepository.save(user);

        // // Generate a 4-digit verification code
        // const token = Math.floor(1000 + Math.random() * 9000).toString();
        
        // const userVerification = this.userVerificationRepository.create({
        //     userId: savedUser.id,
        //     token,
        //     expiresAt: new Date(Date.now() + 10 * 60 * 1000), // 10 minutes from now
        //     createdAt: new Date(),
        // });

        // await this.userVerificationRepository.save(userVerification);

        // // Send verification email
        // try {
        //     await this.emailService.sendVerificationEmail(savedUser.email, savedUser.fullName, token);
        // } catch (error) {
        //     console.error('Failed to send verification email:', error);
        //     // Don't fail the registration if email fails
        // }

        return savedUser;
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

        return user;
    }

    async verifyEmail(verifyEmailDto: VerifyEmailDto){
        const user = await this.userService.findUserByEmail(verifyEmailDto.email);
        if (!user){
            throw new UnauthorizedException('User not found');
        }

        const userVerification = await this.userVerificationRepository.findOne({where: {token: verifyEmailDto.token}});
        if (!userVerification){
            throw new UnauthorizedException('Invalid verification token');
        }

       

        if (user.id !== userVerification.userId){
            throw new UnauthorizedException('Invalid verification token');
        }

        if (userVerification.expiresAt < new Date()){
            throw new UnauthorizedException('Verification token expired');
        }

        

        await this.userRepository.save(user);
        
    }
}
