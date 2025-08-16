import 'package:get/get.dart';
import 'package:mini_store/app/routes/app_pages.dart';

class ProductsController extends GetxController {
  void navigateToListings(Map<String, dynamic> category) {
    Get.toNamed(
      Routes.LISTINGS,
      arguments: {'category': category['name'], 'categoryData': category},
    );
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
    super.onClose();
  }

  void increment() => count.value++;
}
