import { IsNotEmpty, IsOptional, IsString, ValidateNested } from "class-validator";
import { AddressDto } from "./addressDto";
import { Type } from "class-transformer";
export class ProviderSignupDto {
    @IsNotEmpty()
    @IsString()
    idToken: string;

    @IsOptional()
    @ValidateNested()
    @Type(() => AddressDto)
    address?: AddressDto;
}