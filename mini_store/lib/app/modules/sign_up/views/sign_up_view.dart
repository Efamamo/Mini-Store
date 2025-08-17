import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/auth_button.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/auth_toggle.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/custom_test_field.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/oauth.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/separator.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/welcome.dart';
import 'package:mini_store/app/routes/app_pages.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  final _signUpformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Welcome(
              headText: "Sign Up",
              subText: "Create an account and get started today.",
              image: "assets/icons/signup.png",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: OAUTH(
                      name: "Google",
                      icon: "assets/icons/google.png",
                      onPressed: () {
                        controller.handleGoogleSignIn();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: OAUTH(
                      name: "Facebook",
                      icon: "assets/icons/facebook.png",
                      onPressed: () {
                        controller.handleFacebookSignIn();
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Separator(text: "Or"),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 0,
              ),
              child: Obx(
                () => Form(
                  key: _signUpformKey,
                  autovalidateMode:
                      controller.submitClicked.value
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      CustomTextField(
                        icon: Icons.person,
                        controller: controller.nameController,
                        hintText: "Full Name",
                        showSuffix: false,
                        validator: controller.validateName,
                      ),

                      const SizedBox(height: 20),
                      CustomTextField(
                        icon: Icons.email,
                        controller: controller.emailController,
                        hintText: "Email",
                        showSuffix: false,
                        validator: controller.validateEmail,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: controller.passwordController,
                        hintText: "Password",
                        icon: Icons.lock,
                        showSuffix: true,
                        validator: controller.validatePassword,
                      ),

                      const SizedBox(height: 20),
                      const SizedBox(height: 8),
                      CustomTextField(
                        icon: Icons.lock_outline,
                        controller: controller.confirmPasswordController,
                        hintText: "Confirm Password",
                        showSuffix: true,
                        validator: (value) {
                          if (value != controller.passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 30),
                      // Primary Sign Up button (with address)
                      AuthButton(
                        widget: Text(
                          "Continue",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ontap: () {
                          controller.submitClicked.value = true;
                          bool valid = _signUpformKey.currentState!.validate();
                          if (valid) {
                            controller.signUpWithAddress();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AuthToggle(
              message: "Already have an account?",
              to: Routes.LOGIN,
              toText: "Login",
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
