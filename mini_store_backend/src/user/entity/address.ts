import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity()
export class Address {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    storeName: string;

    @Column()
    latitude: string;

    @Column()
    longitude: string;
    
}