import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/auth_button.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/custom_test_field.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/welcome.dart';
import 'package:mini_store/app/routes/app_pages.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  final GlobalKey<FormState> _forgotPasswordKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F7F1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Welcome(
              headText: "Forgot Password",
              subText: "Trouble logging in? Let's help you recover access.",
              image: "assets/icons/forgot-password.png",
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: 20,
              ),
              child: Obx(
                () => Form(
                  key: _forgotPasswordKey,
                  autovalidateMode:
                      controller.submitClicked.value
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter your email to reset your password",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        icon: Icons.person,
                        controller: controller.emailController,
                        hintText: "Email",
                        showSuffix: false,
                        validator: controller.validateEmail,
                      ),

                      const SizedBox(height: 20),
                      AuthButton(
                        widget: Text(
                          "Send Reset OTP",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        ontap: () {
                          controller.submitClicked.value = true;
                          if (_forgotPasswordKey.currentState!.validate()) {
                            Get.toNamed(Routes.OTP_PAGE);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
