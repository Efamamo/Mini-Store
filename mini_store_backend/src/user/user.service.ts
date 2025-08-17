import { Injectable } from '@nestjs/common';
import { User } from './entity/user';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class UserService {

    constructor( @InjectRepository(User) private userRepository: Repository<User>){}
    
    async findUserByEmail(email: string){
        return this.userRepository.findOne({where: {email}});
    }

    async findUserById(id: number){
        return this.userRepository.findOne({where: {id}});
    }

  
}
