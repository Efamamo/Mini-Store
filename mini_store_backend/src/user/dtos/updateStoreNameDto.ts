import { IsNotEmpty, IsString } from "class-validator";

export class UpdateStoreNameDto {
    @IsNotEmpty()
    @IsString()
    storeName: string;
}