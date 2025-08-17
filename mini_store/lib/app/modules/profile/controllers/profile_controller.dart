import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mini_store/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  // Observable variables for profile features
  final currentLanguage = 'English'.obs;
  final currentTheme = 'Light Theme'.obs;
  final isDarkMode = false.obs;
  final isLanguageExpanded = false.obs;

  // Profile data observables
  final userName = 'User'.obs;
  final userEmail = 'user@gmail.com'.obs;
  final userAddress = 'Addis Ababa, Ethiopia'.obs;

  // Store information observables
  final storeName = 'My Store'.obs;
  final storeAddress = 'Addis Ababa, Ethiopia'.obs;

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

  // Language expansion management
  void toggleLanguageExpansion() {
    isLanguageExpanded.value = !isLanguageExpanded.value;
  }

  // Language management
  void changeLanguage(String language) {
    currentLanguage.value = language;
    // Here you would typically implement actual language change logic
    // using Get.locale or similar internationalization methods
  }

  // Theme management
  void changeTheme(String theme) {
    currentTheme.value = theme;
    switch (theme) {
      case 'Light Theme':
        isDarkMode.value = false;
        // Implement light theme logic
        break;
      case 'Dark Theme':
        isDarkMode.value = true;
        // Implement dark theme logic
        break;
      case 'Auto Theme':
        // Implement auto theme logic based on system preference
        break;
    }
  }

  // Profile update methods
  void updateName(String newName) {
    if (newName.trim().isNotEmpty) {
      userName.value = newName.trim();
      Get.back();
      Get.snackbar(
        'Success',
        'Name updated successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
      );
    }
  }

  void updateEmail(String newEmail) {
    // Simple email validation regex
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (newEmail.trim().isNotEmpty && emailRegex.hasMatch(newEmail.trim())) {
      userEmail.value = newEmail.trim();
      Get.back();
      Get.snackbar(
        'Success',
        'Email updated successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Password change
  void changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) {
    if (newPassword != confirmPassword) {
      Get.snackbar(
        'Error',
        'New password and confirm password do not match',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (newPassword.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters long',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Here you would typically implement API call to change password
    Get.snackbar(
      'Success',
      'Password changed successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF10B981),
      colorText: Colors.white,
    );
  }

  // Logout functionality
  void logout() {
    // Implement logout logic here
    // Clear user data, tokens, etc.
    // Navigate to login screen
  }

  // Account deletion
  void deleteAccount() {
    // Implement account deletion logic here
    // This would typically involve API calls to your backend
    // Clear all user data and navigate to landing page
    Get.snackbar(
      'Account Deleted',
      'Your account has been permanently deleted',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFFEF4444),
      colorText: Colors.white,
    );
    // Navigate to landing page after account deletion
    Get.offAllNamed(Routes.LANDING_PAGE);
  }

  // Help and support
  void contactSupport(String method) {
    switch (method) {
      case 'email':
        // Open email app or compose email
        break;
      case 'phone':
        // Make phone call
        break;
      case 'chat':
        // Open live chat
        break;
    }
  }

  // Store information update methods
  void updateStoreName(String newStoreName) {
    if (newStoreName.trim().isNotEmpty) {
      storeName.value = newStoreName.trim();
      Get.back();
      Get.snackbar(
        'Success',
        'Store name updated successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
      );
    }
  }

  void updateStoreAddress(String newStoreAddress) {
    if (newStoreAddress.trim().isNotEmpty) {
      storeAddress.value = newStoreAddress.trim();
      Get.back();
      Get.snackbar(
        'Success',
        'Store address updated successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
      );
    }
  }
}
