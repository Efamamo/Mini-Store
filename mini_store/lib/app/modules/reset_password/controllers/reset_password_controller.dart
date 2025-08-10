import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ResetPasswordController extends GetxController {
  //TODO: Implement ResetPasswordController

  final count = 0.obs;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
