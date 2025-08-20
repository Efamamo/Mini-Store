import { Body, Controller, Get, Param, Patch, Post, Query, Request, UseGuards } from '@nestjs/common';
import { SignupDto } from './dtos/signupDto';
import { AuthService } from './auth.service';
import { LoginDto } from './dtos/loginDto';
import { VerifyEmailDto } from './dtos/verifyEmailDto';
import { RefreshTokenDto } from './dtos/refreshTokenDto';
import { EmailTakenDto } from '../user/dtos/emailTakenDto';
import { ProviderSignupDto } from './dtos/providerSignupDto';
import { ProviderSigninDto } from './dtos/providerSigninDto';
import { AuthGuard } from './guards/auth.guards';

@Controller('auth')
export class AuthController {
    constructor(private authService: AuthService){}
    @Post('signup')
    registerUser(@Body() userRegisterDto: SignupDto){
        return this.authService.registerUser(userRegisterDto);
    }

    @Post("signin")
    login(@Body() loginDto: LoginDto){
        return this.authService.login(loginDto);
    }

    @Post("refresh-token")
    refreshToken(@Body() refreshTokenDto: RefreshTokenDto){
        return this.authService.refreshToken(refreshTokenDto);
    }

   

    @Post("signup/google")
    signupWithGoogle(@Body() providerSignupDto: ProviderSignupDto){
        return this.authService.signupWithGoogle(providerSignupDto);
    }

    @Post("signup/facebook")
    signupWithFacebook(@Body() providerSignupDto: ProviderSignupDto){
        return this.authService.signupWithFacebook(providerSignupDto);
    }

    @Post("signin/google")
    signinWithGoogle(@Body() providerSignupDto: ProviderSigninDto){
        return this.authService.signinWithGoogle(providerSignupDto);
    }

    @Post("signin/facebook")
    signinWithFacebook(@Body() providerSignupDto: ProviderSigninDto){
        return this.authService.signinWithFacebook(providerSignupDto);
    }

    
}
