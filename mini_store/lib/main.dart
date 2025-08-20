import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  // Make sure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
