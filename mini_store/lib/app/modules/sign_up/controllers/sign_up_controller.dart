import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignUpController extends GetxController {
  final count = 0.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
