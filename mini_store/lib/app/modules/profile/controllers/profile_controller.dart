import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mini_store/app/routes/app_pages.dart';
import 'package:mini_store/app/data/repositories/auth.dart';
import 'package:mini_store/app/data/repositories/user.dart';

class ProfileController extends GetxController {
  final AuthRepository authRepository = AuthRepository();
  final UserRepository userRepository = UserRepository();
  // Observable variables for profile features
  final currentLanguage = 'English'.obs;
  final currentTheme = 'Light Theme'.obs;
  final isDarkMode = false.obs;
  final isLanguageExpanded = false.obs;
  final fromProvider = false.obs;

  // Profile data observables
  final userName = '-'.obs;
  final userEmail = '-'.obs;

  // Store information observables
  final storeName = '-'.obs;
  final storeAddress = '-'.obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
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
  ) async {
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

    final result = await userRepository.changePassword(
      currentPassword,
      newPassword,
    );
    if (result) {
      Get.snackbar(
        'Success',
        'Password changed successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
      );
    }
  }

  Future<void> getUserData() async {
    final user = await userRepository.getUserData();
    if (user != null) {
      userName.value = user.fullName;
      userEmail.value = user.email;
      if (user.address != null &&
          user.address!.latitude.isNotEmpty &&
          user.address!.longitude.isNotEmpty) {
        storeAddress.value = await _getPlaceName(
          double.parse(user.address!.latitude),
          double.parse(user.address!.longitude),
        );
      }
      storeName.value = user.address?.storeName ?? '-';
      fromProvider.value = user.fromProvider;
    }
  }

  // Logout functionality
  void logout() {
    authRepository.logout();
    Get.offAllNamed(Routes.LOGIN);
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

  Future<String> _getPlaceName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String placeName = "";

        // Build a readable address
        if (place.street != null && place.street!.isNotEmpty) {
          placeName += place.street!;
        }
        if (place.subLocality != null && place.subLocality!.isNotEmpty) {
          if (placeName.isNotEmpty) placeName += ", ";
          placeName += place.subLocality!;
        }
        if (place.locality != null && place.locality!.isNotEmpty) {
          if (placeName.isNotEmpty) placeName += ", ";
          placeName += place.locality!;
        }
        if (place.administrativeArea != null &&
            place.administrativeArea!.isNotEmpty) {
          if (placeName.isNotEmpty) placeName += ", ";
          placeName += place.administrativeArea!;
        }
        if (place.country != null && place.country!.isNotEmpty) {
          if (placeName.isNotEmpty) placeName += ", ";
          placeName += place.country!;
        }

        // If we couldn't build a readable address, use coordinates as fallback
        if (placeName.isEmpty) {
          placeName =
              "Lat: ${latitude.toStringAsFixed(4)}, Lng: ${longitude.toStringAsFixed(4)}";
        }

        return placeName;
      } else {
        return "Lat: ${latitude.toStringAsFixed(4)}, Lng: ${longitude.toStringAsFixed(4)}";
      }
    } catch (e) {
      print("Error getting place name: $e");
      return "Lat: ${latitude.toStringAsFixed(4)}, Lng: ${longitude.toStringAsFixed(4)}";
    }
  }
}
