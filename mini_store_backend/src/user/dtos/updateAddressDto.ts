import { IsNotEmpty, IsString } from "class-validator";

export class UpdateAddressDto {
    @IsNotEmpty()
    @IsString()
    latitude: string;

    @IsNotEmpty()
    @IsString()
    longitude: string;

}   