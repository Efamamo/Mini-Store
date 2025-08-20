import { IsNotEmpty, IsString,  } from "class-validator";
export class ProviderSigninDto {
    @IsNotEmpty()
    @IsString()
    idToken: string;

  
}