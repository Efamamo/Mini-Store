import { IsEmail, IsNotEmpty, IsOptional, IsString, MinLength, ValidateNested } from "class-validator";
import { AddressDto } from "./addressDto";
import { Type } from "class-transformer";

export class SignupDto {
    @IsString()
    @IsNotEmpty()
    fullName: string;

    @IsEmail()
    @IsNotEmpty()
    email: string;

    @IsString()
    @IsNotEmpty()
    @MinLength(6)
    password: string;


    @IsOptional()
    @ValidateNested()
    @Type(() => AddressDto)
    address?: AddressDto;
}