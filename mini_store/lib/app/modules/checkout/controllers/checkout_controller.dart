import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../views/location_picker_view.dart';

class CheckoutController extends GetxController {
  final RxBool isSantimPay = true.obs;
  final RxBool hasPickedLocation = false.obs;
  final RxBool isLoading = false.obs;
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;
  final RxString placeName = "".obs;

  final items;

  CheckoutController({required this.items});

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

  void toggleSantimPay(bool value) {
    isSantimPay.value = value;
  }

  void toggleChapa(bool value) {
    isSantimPay.value = !value;
  }

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

  Future<void> processChapaCheckout() async {
    if (!hasPickedLocation.value) {
      Get.snackbar(
        "Warning",
        "Please pick a location first.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Simulate checkout process
      await Future.delayed(Duration(seconds: 2));

      Get.snackbar(
        "Success",
        "Checkout completed successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Here you would typically navigate to a payment page or success page
      // Get.to(() => PaymentSuccessPage());
    } catch (e) {
      Get.snackbar(
        "Error",
        "Checkout failed. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool get canProceedWithChapa => !isSantimPay.value && hasPickedLocation.value;
}
