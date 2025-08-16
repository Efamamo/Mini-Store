import 'package:get/get.dart';
import 'package:mini_store/app/modules/cart/controllers/cart_controller.dart';
import 'package:mini_store/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:mini_store/app/modules/products/controllers/products_controller.dart';
import 'package:mini_store/app/modules/profile/controllers/profile_controller.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final selectedIndex = 0.obs;

  @override
  void onInit() {
    Get.lazyPut(() => ProductsController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => DashboardController());
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

  void onBottomNavTap(int index) {
    selectedIndex.value = index;
  }
}
