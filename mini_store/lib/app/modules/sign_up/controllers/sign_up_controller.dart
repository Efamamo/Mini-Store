import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mini_store/app/data/repositories/auth.dart';
import 'package:mini_store/app/data/repositories/user.dart';
import 'package:mini_store/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  final AuthRepository authRepository = AuthRepository();
  final UserRepository userRepository = UserRepository();
  final count = 0.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  var submitClicked = false.obs;

  String? validateEmail(email) {
    if (email.length == 0) {
      return "Email is required";
    }
    final emailRegex = RegExp(r'^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$');
    final valid = emailRegex.hasMatch(email);
    if (valid) {
      return null;
    }
    return 'Email is Invalid';
  }

  String? validatePassword(password) {
    if (password.length == 0) {
      return 'Password is Required';
    }
    bool valid = password.length >= 6;
    if (valid) {
      return null;
    }
    return 'Minimum password length is 6';
  }

  String? validateName(name) {
    if (name.length == 0) {
      return 'Name is Required';
    }
    bool valid = name.length >= 3;
    if (valid) {
      return null;
    }
    return 'Minimum name length is 3';
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        "130010460553-cftrflh6d6qcb243a6a1m5q4p7f32km0.apps.googleusercontent.com",
    scopes: ['email', 'profile'],
  );

  Future<void> handleGoogleSignIn() async {
    try {
      await _googleSignIn.signOut();
      final account = await _googleSignIn.signIn();

      if (account == null) {
        print("User canceled Google sign-in");
        return;
      }

      final auth = await account.authentication;

      final idToken = auth.idToken;

      if (idToken != null) {
        final result = await authRepository.signUpWithGoogle(
          idToken,
          null,
          null,
          null,
        );
        if (result != null) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('accessToken', result.accessToken);
          prefs.setString('refreshToken', result.refreshToken);
          prefs.setString('fullName', result.fullName);
          prefs.setString('id', result.id);
          prefs.setString('email', result.email);
          Get.offNamedUntil(Routes.HOME, (route) => false);
        }
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  Future<void> handleFacebookSignIn() async {
    try {
      await FacebookAuth.instance.logOut();
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      );

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final res = await authRepository.signUpWithFacebook(
          accessToken.tokenString,
          null,
          null,
          null,
        );
        if (res != null) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('accessToken', res.accessToken);
          prefs.setString('refreshToken', res.refreshToken);
          prefs.setString('fullName', res.fullName);
          prefs.setString('id', res.id);
          prefs.setString('email', res.email);
          Get.offNamedUntil(Routes.HOME, (route) => false);
        }
      }
    } catch (error) {
      print("Facebook Sign-In Error: $error");
    }
  }

  Future<void> signUpWithAddress() async {
    final isEmailTaken = await userRepository.checkEmailExists(
      emailController.text,
    );
    if (isEmailTaken) {
      return;
    }
    // Navigate to address setup page
    Get.toNamed(
      Routes.ADDRESS,
      arguments: {
        'email': emailController.text,
        'password': passwordController.text,
        'fullName': nameController.text,
      },
    );
  }

  void signUpWithoutAddress() {
    // Skip address setup and go directly to home
    // Here you would typically handle user registration with backend
    // For now, just navigate to home
    Get.offAllNamed(Routes.HOME);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
