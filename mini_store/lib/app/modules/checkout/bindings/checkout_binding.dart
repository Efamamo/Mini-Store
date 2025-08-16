import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';

class CheckoutBinding extends Bindings {
  final items;

  CheckoutBinding({required this.items});

  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(() => CheckoutController(items: items));
  }
}
