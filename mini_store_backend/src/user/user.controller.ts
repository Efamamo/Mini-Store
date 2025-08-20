import { Body, Controller, Delete, Get, Patch, Query, Request, UseGuards } from '@nestjs/common';
import { UserService } from './user.service';
import { AuthGuard } from 'src/auth/guards/auth.guards';
import { EmailTakenDto } from './dtos/emailTakenDto';
import { UpdateNameDto } from './dtos/updateNameDto';
import { UpdateStoreNameDto } from './dtos/updateStoreNameDto';
import { UpdateAddressDto } from './dtos/updateAddressDto';
import { ChangePasswordDto } from './dtos/changePasswordDto';
import { DeleteAccountDto } from './dtos/deleteAccountDto';

@Controller('users')
export class UserController {
    constructor(private userService: UserService){}

    @UseGuards(AuthGuard) 
    @Get("/:id")   
    getUser(@Request() req){
        return this.userService.getUser(req.userId);
    }


    @Get("/check-email-taken")
    checkEmailTaken(@Query() emailTakenDto: EmailTakenDto){
        return this.userService.checkEmailTaken(emailTakenDto);
    }

    @UseGuards(AuthGuard)
    @Patch("/:id/name")
    updateName(@Request() req, @Body() updateNameDto: UpdateNameDto){
        return this.userService.updateName(req.userId, updateNameDto);
    }

    @UseGuards(AuthGuard)
    @Patch("/:id/store")
    updateStoreName(@Request() req, @Body() updateStoreNameDto: UpdateStoreNameDto){
        return this.userService.updateStoreName(req.userId, updateStoreNameDto);
    }

    @UseGuards(AuthGuard)
    @Patch("/:id/address")
    updateAddress(@Request() req, @Body() updateAddressDto: UpdateAddressDto){
        return this.userService.updateAddress(req.userId, updateAddressDto);
    }

    @UseGuards(AuthGuard)
    @Patch("/:id/password")
    changePassword(@Request() req, @Body() changePasswordDto: ChangePasswordDto){
        return this.userService.changePassword(req.userId, changePasswordDto);
    }

    @UseGuards(AuthGuard)
    @Delete("/:id")
    deleteAccount(@Request() req, @Body() deleteAccountDto: DeleteAccountDto){
        return this.userService.deleteAccount(req.userId, deleteAccountDto);
    }
}
