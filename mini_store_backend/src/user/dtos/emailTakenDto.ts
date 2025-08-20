import { IsNotEmpty, IsString } from "class-validator";

export class EmailTakenDto {
  @IsNotEmpty()
  @IsString()
  email: string;
}