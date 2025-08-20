import { forwardRef, Module } from '@nestjs/common';
import { User } from './entity/user';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Address } from './entity/address';
import { UserService } from './user.service';
import { UserVerification } from './entity/userVerification';
import { UserController } from './user.controller';
import { AuthModule } from 'src/auth/auth.module';

@Module({
    imports: [TypeOrmModule.forFeature([User, Address, UserVerification]),forwardRef(() => AuthModule)],
    controllers: [UserController],
    providers: [UserService],
    exports: [UserService],
})
export class UserModule {
    
}
