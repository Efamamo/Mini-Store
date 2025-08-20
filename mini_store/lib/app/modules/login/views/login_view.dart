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
      backgroundColor: Colors.grey[50],
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
                        icon: Icons.email,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Fingerprint authentication button
                          Obx(
                            () =>
                                controller.isBiometricAvailable.value
                                    ? !controller.hasUserLoggedInBefore.value
                                        ? const SizedBox.shrink()
                                        : GestureDetector(
                                          onTap:
                                              controller.isAuthenticating.value
                                                  ? null
                                                  : () {
                                                    controller
                                                        .authenticateWithBiometrics();
                                                  },
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                color: const Color(
                                                  0xFF3B82F6,
                                                ).withOpacity(0.3),
                                              ),
                                            ),
                                            child:
                                                controller
                                                        .isAuthenticating
                                                        .value
                                                    ? const SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                              Color
                                                            >(
                                                              Color(0xFF3B82F6),
                                                            ),
                                                      ),
                                                    )
                                                    : const Icon(
                                                      Icons.fingerprint,
                                                      color: Color(0xFF3B82F6),
                                                      size: 24,
                                                    ),
                                          ),
                                        )
                                    : const SizedBox.shrink(),
                          ),
                        ],
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
                            controller.login();
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
