import { IsOptional, IsString } from "class-validator";

export class DeleteAccountDto {
    @IsString()
    @IsOptional()
    password?: string;
}