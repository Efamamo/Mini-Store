import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/auth_button.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/auth_toggle.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/custom_test_field.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/oauth.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/separator.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/welcome.dart';
import 'package:mini_store/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final GlobalKey<FormState> _signinKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F7F1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Welcome(
              headText: "Sign In",
              subText: "Welcome back! Please log in to continue.",
              image: "assets/icons/login.png",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: OAUTH(
                      name: "Google",
                      icon: "assets/icons/google.png",
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: OAUTH(
                      name: "Facebook",
                      icon: "assets/icons/facebook.png",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Separator(text: "Or"),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 0,
              ),
              child: Obx(
                () => Form(
                  key: _signinKey,
                  autovalidateMode:
                      controller.submitClicked.value
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      CustomTextField(
                        icon: Icons.person,
                        controller: controller.emailController,
                        hintText: "Email",
                        showSuffix: false,
                        validator: controller.validateEmail,
                      ),

                      const SizedBox(height: 20),
                      CustomTextField(
                        icon: Icons.lock,
                        controller: controller.passwordController,
                        hintText: "Password",
                        showSuffix: true,
                        validator: controller.validatePassword,
                      ),

                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.FORGOT_PASSWORD);
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      AuthButton(
                        widget: Text(
                          "Login",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),

                        ontap: () {
                          controller.submitClicked.value = true;
                          if (_signinKey.currentState!.validate()) {
                            Get.toNamed(Routes.HOME);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AuthToggle(
              message: "Don't have an account?",
              to: Routes.SIGN_UP,
              toText: "Sign up",
            ),
          ],
        ),
      ),
    );
  }
}
