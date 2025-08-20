import 'package:get/get.dart';
import 'package:mini_store/app/modules/checkout/views/location_picker_view.dart';
import 'package:mini_store/app/data/repositories/auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_store/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressController extends GetxController {
  final AuthRepository authRepository = AuthRepository();

  final RxBool hasPickedLocation = false.obs;
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;
  final RxString placeName = "".obs;
  final RxString email = "".obs;
  final RxString password = "".obs;
  final RxString fullName = "".obs;

  // Store name controller and validation
  final TextEditingController storeNameController = TextEditingController();
  final RxBool isStoreNameValid = false.obs;

  Future<void> pickCurrentLocation() async {
    try {
      // Open location picker with current coordinates or default to Addis Ababa
      double initialLat = hasPickedLocation.value ? latitude.value : 9.0820;
      double initialLng = hasPickedLocation.value ? longitude.value : 38.7636;

      Get.to(
        () => LocationPickerView(
          initialLatitude: initialLat,
          initialLongitude: initialLng,
          onLocationSelected: (lat, lng, place) {
            // Update the location values
            latitude.value = lat;
            longitude.value = lng;
            placeName.value = place;
            hasPickedLocation.value = true;
          },
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to open location picker: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Validate store name
  void validateStoreName() {
    final name = storeNameController.text.trim();
    isStoreNameValid.value = name.isNotEmpty && name.length >= 2;
  }

  // Check if form is complete
  bool get isFormComplete => hasPickedLocation.value && isStoreNameValid.value;

  Future<void> signUpWithAddress() async {
    final result = await authRepository.signUp(
      email.value,
      password.value,
      fullName.value,
      storeNameController.text,
      latitude.value.toString(),
      longitude.value.toString(),
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

  Future<void> signUpWithoutAddress() async {
    final result = await authRepository.signUp(
      email.value,
      password.value,
      fullName.value,
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

  @override
  void onInit() {
    super.onInit();

    email.value = Get.arguments['email'];
    password.value = Get.arguments['password'];
    fullName.value = Get.arguments['fullName'];

    // Listen to store name changes
    storeNameController.addListener(validateStoreName);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    storeNameController.dispose();
    super.onClose();
  }
}
