import { forwardRef, Module } from '@nestjs/common';
import { UserModule } from 'src/user/user.module';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { Address } from 'src/user/entity/address';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from 'src/user/entity/user';
import { UserVerification } from 'src/user/entity/userVerification';
import { EmailModule } from 'src/email/email.module';
import { JwtModule } from '@nestjs/jwt';
import { JWT_ACCESS_SECRET } from 'src/config/jwt.config';
import { AuthGuard } from './guards/auth.guards';

@Module({
    imports: [
        forwardRef(() => UserModule),  
        TypeOrmModule.forFeature([User, Address, UserVerification]), 
        EmailModule,
        JwtModule.register({
            secret: JWT_ACCESS_SECRET,
            signOptions: { expiresIn: '1h' },
        }),
    ],
    controllers: [AuthController],
    providers: [AuthService, AuthGuard],
    exports: [AuthGuard],
})
export class AuthModule {}
