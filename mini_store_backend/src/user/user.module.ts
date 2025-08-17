import { Module } from '@nestjs/common';
import { User } from './entity/user';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Address } from './entity/address';
import { UserService } from './user.service';
import { UserVerification } from './entity/userVerification';

@Module({
    imports: [TypeOrmModule.forFeature([User, Address, UserVerification])],
    controllers: [],
    providers: [UserService],
    exports: [UserService],
})
export class UserModule {
    
}
