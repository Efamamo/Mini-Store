import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ForgotPasswordController extends GetxController {
  //TODO: Implement ForgotPasswordController
  final count = 0.obs;
  final TextEditingController emailController = TextEditingController();
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
