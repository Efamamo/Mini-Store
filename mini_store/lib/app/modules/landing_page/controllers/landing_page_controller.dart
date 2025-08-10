import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_store/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPageController extends GetxController {
  final PageController pageController = PageController();
  var currentPage = 0.obs;

  void onNextPressed() {
    if (currentPage < 3) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      visit();
      Get.toNamed(Routes.SIGN_UP);
    }
  }

  Future<void> visit() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("hasVisited", true);
  }

  final count = 0.obs;
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
    pageController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
