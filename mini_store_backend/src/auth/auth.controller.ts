import { Body, Controller, Patch, Post } from '@nestjs/common';
import { SignupDto } from './dtos/signupDto';
import { AuthService } from './auth.service';
import { LoginDto } from './dtos/loginDto';
import { VerifyEmailDto } from './dtos/verifyEmailDto';

@Controller('auth')
export class AuthController {
    constructor(private authService: AuthService){}
    @Post('register')
    registerUser(@Body() userRegisterDto: SignupDto){
        return this.authService.registerUser(userRegisterDto);
    }

    @Post("login")
    login(@Body() loginDto: LoginDto){
        return this.authService.login(loginDto);
    }

    @Patch('verify-email')
    verifyEmail(@Body() verifyEmailDto: VerifyEmailDto){
        return this.authService.verifyEmail(verifyEmailDto);
    }
}
