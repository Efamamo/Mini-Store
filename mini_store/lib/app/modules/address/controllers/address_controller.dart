import 'package:get/get.dart';
import 'package:mini_store/app/modules/checkout/views/location_picker_view.dart';
import 'package:flutter/material.dart';

class AddressController extends GetxController {
  final RxBool hasPickedLocation = false.obs;
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;
  final RxString placeName = "".obs;

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

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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

  void increment() => count.value++;
}
