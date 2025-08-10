import 'package:get/get.dart';
import 'package:mini_store/app/modules/landing_page/controllers/landing_page_controller.dart';
import 'package:mini_store/app/modules/login/controllers/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WrapperController extends GetxController {
  var finishedFetching = false.obs;
  var hasUserVisited = false.obs;

  Future<void> getSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    hasUserVisited.value = prefs.getBool("hasVisited") ?? false;

    finishedFetching.value = true;
  }

  final count = 0.obs;
  @override
  void onInit() {
    Get.lazyPut(() => LandingPageController());
    Get.lazyPut(() => LoginController());

    getSharedPref();
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
