import { Module } from '@nestjs/common';
import { AuthController } from './auth/auth.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './user/entity/user';
import { Address } from './user/entity/address';
import { UserModule } from './user/user.module';
import { AuthModule } from './auth/auth.module';
import { UserVerification } from './user/entity/userVerification';
import { JwtModule } from '@nestjs/jwt';

@Module({
  imports: [TypeOrmModule.forRoot({
    type: 'postgres',
    host: 'ep-hidden-cell-abggfjmr-pooler.eu-west-2.aws.neon.tech',
    port: 5432,
    username: 'neondb_owner',
    password: 'npg_zuT0k6vnLVUZ',
    database: 'mini_store',
    entities: [User, Address, UserVerification],
    synchronize: true,
    ssl: true,
  }), JwtModule.register({
    global: true,    
    signOptions: { expiresIn: '1h' },
  }), UserModule, AuthModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
