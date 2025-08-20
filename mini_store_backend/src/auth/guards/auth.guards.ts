import { CanActivate, ExecutionContext, Injectable, UnauthorizedException } from "@nestjs/common";
import { JwtService } from "@nestjs/jwt";
import * as jwt from 'jsonwebtoken';
import { JWT_ACCESS_SECRET } from "src/config/jwt.config";

@Injectable()
export class AuthGuard implements CanActivate {
    constructor(private readonly jwtService: JwtService){}
    async canActivate(context: ExecutionContext) {
        try{
            const request = context.switchToHttp().getRequest();
            const authHeader = request.headers.authorization;
            
            if (!authHeader) {
                throw new UnauthorizedException('Authorization header is missing');
            }
            
            const token = authHeader.split(" ")[1];
            const decoded = await this.jwtService.verify(token, {secret: JWT_ACCESS_SECRET});
            request.userId = decoded.sub;
            return true;
        }catch(err){
            console.log(err);
            throw new UnauthorizedException('Invalid token');
        }
    }
}