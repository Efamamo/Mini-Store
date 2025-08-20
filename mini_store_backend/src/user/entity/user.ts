import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";
import { Address } from "./address";
import { JoinColumn } from "typeorm";
import { OneToOne } from "typeorm";

@Entity()
export class User {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    fullName: string;

    @Column()
    email: string;

    @Column()
    password: string;



    @OneToOne(() => Address)
    @JoinColumn()
    address: Address;

    @Column({default: false})
    fromProvider: boolean;
    
    
}