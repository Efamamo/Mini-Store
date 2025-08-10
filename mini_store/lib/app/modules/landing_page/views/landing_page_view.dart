import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mini_store/app/modules/landing_page/views/landing_widget.dart';

import '../controllers/landing_page_controller.dart';

class LandingPageView extends GetView<LandingPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F7F1),
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: (int page) {
              controller.currentPage.value = page;
            },
            children: const [
              Landing(
                image: 'assets/images/store.png',
                pageIndex: 0,
                title: "Start Little, Go Big.",
                description:
                    "Discover new products and enjoy seamless shopping.",
              ),
              Landing(
                image: 'assets/images/deliveries.png',
                pageIndex: 1,
                title: "Fast Delivery",
                description: "Get your orders delivered swiftly and safely.",
              ),
              Landing(
                image: 'assets/images/payment.png',
                pageIndex: 2,
                title: "Secure Payment",
                description: "Your payments are safe with our secure system.",
              ),
              Landing(
                image: 'assets/images/launch.png',
                pageIndex: 3,
                title: "Let's Get Started",
                description: "",
              ),
            ],
          ),

          // Positioned widget for indicators and button
          Obx(
            () => Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: 25,
                        height: 2,
                        decoration: BoxDecoration(
                          color:
                              controller.currentPage.value == index
                                  ? const Color.fromARGB(255, 40, 39, 39)
                                  : Colors.grey,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 10.0),
                  // Circular Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      elevation: 5,
                    ),
                    onPressed: controller.onNextPressed,
                    child: Text(
                      controller.currentPage.value < 3 ? "Next" : "Go",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
