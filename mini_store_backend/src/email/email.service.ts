import { Injectable } from '@nestjs/common';
import sgMail from '@sendgrid/mail';

@Injectable()
export class EmailService {
    constructor() {
        // Initialize SendGrid with your API key from environment variables
        const apiKey = process.env.SENDGRID_API_KEY;
        if (apiKey) {
            sgMail.setApiKey(apiKey);
        } else {
            console.warn('SENDGRID_API_KEY not found in environment variables');
        }
    }

    async sendVerificationEmail(email: string, fullName: string, token: string): Promise<void> {
        const msg = {
            to: email,
            from: process.env.SENDGRID_FROM_EMAIL || "ephremmamo555@gmail.com", 
            subject: 'Verify Your Email Address',
            html: this.getVerificationEmailTemplate(fullName, token),
        };

        try {
            await sgMail.send(msg);
            console.log(`Verification email sent to ${email}`);
        } catch (error) {
            console.error('Error sending verification email:', error);
            throw new Error('Failed to send verification email');
        }
    }

    private getVerificationEmailTemplate(fullName: string, token: string): string {
        return `
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Verify Your Email</title>
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background: #007bff; color: white; padding: 20px; text-align: center; border-radius: 5px 5px 0 0; }
                    .content { background: #f8f9fa; padding: 30px; border-radius: 0 0 5px 5px; }
                    .verification-code { background: #007bff; color: white; padding: 15px; text-align: center; font-size: 24px; font-weight: bold; border-radius: 5px; margin: 20px 0; }
                    .footer { text-align: center; margin-top: 30px; color: #666; font-size: 14px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>Welcome to Mini Store!</h1>
                    </div>
                    <div class="content">
                        <h2>Hi ${fullName},</h2>
                        <p>Thank you for registering with Mini Store. To complete your registration, please use the verification code below:</p>
                        
                        <div class="verification-code">
                            ${token}
                        </div>
                        
                        <p>This code will expire in 10 minutes. If you didn't request this verification, please ignore this email.</p>
                        
                        <p>Best regards,<br>The Mini Store Team</p>
                    </div>
                    <div class="footer">
                        <p>This is an automated email. Please do not reply to this message.</p>
                    </div>
                </div>
            </body>
            </html>
        `;
    }
}
