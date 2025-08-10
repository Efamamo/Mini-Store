import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F7F1),
      appBar: AppBar(title: const Text('HomeView'), centerTitle: true),
      body: const Center(
        child: Text('HomeView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
