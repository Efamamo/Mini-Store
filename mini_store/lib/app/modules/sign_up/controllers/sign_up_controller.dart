import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpController extends GetxController {
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

      print("idToken: $idToken");
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
        print("accessToken: $accessToken");
      }
    } catch (error) {
      print("Facebook Sign-In Error: $error");
    }
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
