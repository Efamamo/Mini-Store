import { Module } from '@nestjs/common';
import { UserModule } from 'src/user/user.module';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { Address } from 'src/user/entity/address';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from 'src/user/entity/user';
import { UserVerification } from 'src/user/entity/userVerification';
import { EmailModule } from 'src/email/email.module';

@Module({
    imports: [UserModule, TypeOrmModule.forFeature([User, Address, UserVerification]), EmailModule],
    controllers: [AuthController],
    providers: [AuthService],
})
export class AuthModule {}
