import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:get/get.dart';
import 'package:mini_store/app/modules/cart/views/cart_view.dart';
import 'package:mini_store/app/modules/dashboard/views/dashboard_view.dart';
import 'package:mini_store/app/modules/products/views/products_view.dart';
import 'package:mini_store/app/modules/profile/views/profile_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

      body: Obx(
        () =>
            controller.selectedIndex.value == 0
                ? ProductsView()
                : controller.selectedIndex.value == 1
                ? DashboardView()
                : controller.selectedIndex.value == 2
                ? CartView()
                : controller.selectedIndex.value == 3
                ? ProfileView()
                : const SizedBox.shrink(),
      ),

      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.grey[50],
          selectedItemColor: const Color(0xFF3B82F6),
          unselectedItemColor: Colors.grey.shade500,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          enableFeedback: false,
          currentIndex: controller.selectedIndex.value,
          onTap: controller.onBottomNavTap,
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesome.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesome.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
