import { ConflictException, Injectable, UnauthorizedException } from '@nestjs/common';
import { User } from './entity/user';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { Address } from './entity/address';
import * as bcrypt from 'bcrypt';
import { SignupDto } from 'src/auth/dtos/signupDto';
import { EmailTakenDto } from 'src/user/dtos/emailTakenDto';
import { UpdateNameDto } from './dtos/updateNameDto';
import { UpdateStoreNameDto } from './dtos/updateStoreNameDto';
import { UpdateAddressDto } from './dtos/updateAddressDto';
import { ChangePasswordDto } from './dtos/changePasswordDto';
import { DeleteAccountDto } from './dtos/deleteAccountDto';

@Injectable()
export class UserService {

    constructor( @InjectRepository(User) private userRepository: Repository<User>, @InjectRepository(Address) private addressRepository: Repository<Address>
){}

    async createUser(signupDto: SignupDto) : Promise<User>{
        const hashedPassword = await bcrypt.hash(signupDto.password, 10);

        const user = this.userRepository.create({
            fullName: signupDto.fullName,
            email: signupDto.email,
            password: hashedPassword,
            fromProvider:  signupDto.fromProvider || false,
        });
        
        if (signupDto.address){
            const address = this.addressRepository.create(signupDto.address);
            await this.addressRepository.save(address);
            user.address = address;
        }

        const savedUser = await this.userRepository.save(user);
        return savedUser;
    }

    async checkEmailTaken(emailTokenDto: EmailTakenDto){
        const user = await this.findUserByEmail(emailTokenDto.email);
        if (user){
            throw new ConflictException('Email already taken');
        }
        return { "email": emailTokenDto.email, "isTaken": false};
    }


    async getUser(id: string){
        const user = await this.findUserById(parseInt(id));
        if (!user){
            throw new UnauthorizedException('User not found');
        }
        console.log(user.address);

        let address;

        if (user.address){
            address = await this.addressRepository.findOne({where: {id: user.address.id}});
        }
        
        return { "userId": user.id, "fullName": user.fullName, "email": user.email, "address": address, "fromProvider": user.fromProvider};
    }
    
    async findUserByEmail(email: string){
        return this.userRepository.findOne({where: {email}, relations: ['address']});
    }

    async findUserById(id: number){
        return this.userRepository.findOne({where: {id}, relations: ['address']});
    }

    async updateName(id: string, updateNameDto: UpdateNameDto){
        const user = await this.findUserById(parseInt(id));
        if (!user){
            throw new UnauthorizedException('User not found');
        }
        user.fullName = updateNameDto.fullName;
        return this.userRepository.save(user);
    }

    async updateStoreName(id: string, updateStoreNameDto: UpdateStoreNameDto){
        const user = await this.findUserById(parseInt(id));
        if (!user){
            throw new UnauthorizedException('User not found');
        }

        const address = user.address;
        if (!address){
            const newAddress = await this.addressRepository.save({
                storeName: updateStoreNameDto.storeName,
                latitude: '',
                longitude: '',
            });
            user.address = newAddress;
            return this.userRepository.save(user);
        }
        address.storeName = updateStoreNameDto.storeName;
        
        await this.addressRepository.save(address);
        return this.userRepository.save(user);
    }

    async updateAddress(id: string, updateAddressDto: UpdateAddressDto){
        const user = await this.findUserById(parseInt(id));
        if (!user){
            throw new UnauthorizedException('User not found');
        }

        const address = user.address;
        if (!address){
            await this.addressRepository.save({
                latitude: updateAddressDto.latitude,
                longitude: updateAddressDto.longitude,
                storeName: '',
                userId: user.id,
            });
            return this.userRepository.save(user);
        }
        address.latitude = updateAddressDto.latitude;
        address.longitude = updateAddressDto.longitude;
        await this.addressRepository.save(address);
        return this.userRepository.save(user);
    }

    async changePassword(id: string, changePasswordDto: ChangePasswordDto){
        const user = await this.findUserById(parseInt(id));
        if (!user){
            throw new UnauthorizedException('User not found');
        }
        if (user.fromProvider){
            throw new UnauthorizedException('Cannot change password for account from google/facebook');
        }
        const isPasswordValid = await bcrypt.compare(changePasswordDto.oldPassword, user.password);
        if (!isPasswordValid){
            throw new UnauthorizedException('Invalid old password');
        }
        const hashedPassword = await bcrypt.hash(changePasswordDto.newPassword, 10);
        user.password = hashedPassword;
        return this.userRepository.save(user);
    }

    async deleteAccount(id: string, deleteAccountDto: DeleteAccountDto){
        const user = await this.findUserById(parseInt(id));
        if (!user){
            throw new UnauthorizedException('User not found');
        }

        if (!user.fromProvider){
            if (!deleteAccountDto.password){
                throw new UnauthorizedException('Password is required');
            }
            const isPasswordValid = await bcrypt.compare(deleteAccountDto.password, user.password);
            if (!isPasswordValid){
                throw new UnauthorizedException('Invalid password');
            }
        }
        return this.userRepository.delete(user.id);
    }
}
