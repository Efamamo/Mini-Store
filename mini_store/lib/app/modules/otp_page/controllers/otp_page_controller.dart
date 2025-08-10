import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_store/app/routes/app_pages.dart';

class OtpPageController extends GetxController {
  var otp = "".obs;
  final List<TextEditingController> controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.onClose();
  }

  void handleInput(String value, int index) {
    otp.value += value;
    if (value.length == 1 && index < controllers.length - 1) {
      focusNodes[index + 1].requestFocus(); // Move to the next input
    } else if (value.length == 1 && index == controllers.length - 1) {
      focusNodes[index].unfocus(); // Dismiss the keyboard
      Get.toNamed(Routes.RESET_PASSWORD);
    }
  }

  void handleBackspace(String value, int index) {
    print(value);
    print(index);
    if (index > 0) {
      controllers[index].clear();

      focusNodes[index - 1].requestFocus();
    }
  }

  void clearOTP() {
    for (var controller in controllers) {
      controller.clear();
    }
    otp.value = "";
    focusNodes[0].requestFocus();
  }
}
