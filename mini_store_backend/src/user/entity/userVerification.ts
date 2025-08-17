import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity()
export class UserVerification {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    userId: number;

    @Column()
    token: string;

    @Column()
    expiresAt: Date;

    @Column()
    createdAt: Date;
}