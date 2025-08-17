import { IsNotEmpty, IsString } from "class-validator";

export class AddressDto {
    @IsString()
    @IsNotEmpty()
    storeName: string;

    @IsString()
    @IsNotEmpty()
    latitude: string;

    @IsString()
    @IsNotEmpty()
    longitude: string;

}