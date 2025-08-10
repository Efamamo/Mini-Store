import 'package:get/get.dart';
import '../controllers/otp_page_controller.dart';

class OtpPageBinding extends Bindings {
  @override
  void dependencies() {
    // Register OtpPageController
    Get.lazyPut<OtpPageController>(() => OtpPageController());
  }
}
