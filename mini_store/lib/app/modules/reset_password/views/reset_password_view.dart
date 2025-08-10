import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/auth_button.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/custom_test_field.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/welcome.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  final GlobalKey<FormState> _resetFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F7F1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Welcome(
              headText: "Reset Your Password",
              subText:
                  "Enter OTP and your new password to complete the process.",
              image: "assets/icons/reset-password.png",
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
                  key: _resetFormKey,
                  autovalidateMode:
                      controller.submitClicked.value
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      CustomTextField(
                        icon: Icons.lock,
                        controller: controller.passwordController,
                        hintText: "New Password",
                        showSuffix: true,
                        validator: controller.validatePassword,
                      ),

                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: controller.confirmPasswordController,
                        hintText: "Confirm New Password",
                        icon: Icons.lock,
                        showSuffix: true,
                        validator: (value) {
                          if (value != controller.passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 30),

                      AuthButton(
                        widget: Text(
                          "Reset Password",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),

                        ontap: () {
                          controller.submitClicked.value = true;
                          if (_resetFormKey.currentState!.validate()) {}
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
