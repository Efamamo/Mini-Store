import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mini_store/app/modules/landing_page/views/landing_page_view.dart';
import 'package:mini_store/app/modules/login/views/login_view.dart';

import '../controllers/wrapper_controller.dart';

class WrapperView extends GetView<WrapperController> {
  const WrapperView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.finishedFetching.value) {
        return controller.hasUserVisited.value
            ? LoginView()
            : LandingPageView();
      }
      return const Scaffold(
        backgroundColor: Color(0xffF9F7F1),
        body: Center(child: CircularProgressIndicator()),
      );
    });
  }
}
