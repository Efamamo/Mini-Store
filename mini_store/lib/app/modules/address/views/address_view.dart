import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/auth_button.dart';
import 'package:mini_store/app/global_widgets/auth_widgets/welcome.dart';
import 'package:mini_store/app/routes/app_pages.dart';

import '../controllers/address_controller.dart';

class AddressView extends GetView<AddressController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Welcome(
                headText: "Store Details",
                subText: "Pick your store location and name to get started.",
                image: "assets/icons/map.png",
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Obx(
                  () => ListTile(
                    contentPadding: const EdgeInsets.all(20),
                    onTap: controller.pickCurrentLocation,
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.my_location,
                        color: Color(0xFF10B981),
                        size: 24,
                      ),
                    ),
                    title: Text(
                      !controller.hasPickedLocation.value
                          ? "Choose Store Location"
                          : "Store Location Selected",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    subtitle: Obx(
                      () => Text(
                        !controller.hasPickedLocation.value
                            ? "Tap to select store location on map"
                            : controller.placeName.value.isNotEmpty
                            ? controller.placeName.value
                            : "Store location coordinates saved",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Store Name Input Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3B82F6).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.storefront,
                              color: Color(0xFF3B82F6),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Store Name",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Enter your store or business name",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color:
                                controller.isStoreNameValid.value
                                    ? const Color(0xFF10B981)
                                    : controller
                                        .storeNameController
                                        .text
                                        .isNotEmpty
                                    ? const Color(0xFFEF4444)
                                    : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: TextFormField(
                          controller: controller.storeNameController,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1E293B),
                          ),
                          decoration: InputDecoration(
                            hintText: "e.g., My Amazing Store",
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            suffixIcon:
                                controller.isStoreNameValid.value
                                    ? Container(
                                      margin: const EdgeInsets.all(12),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF10B981),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    )
                                    : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
              AuthButton(
                widget: Text(
                  "Create Account with Store",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                ontap:
                    controller.isFormComplete
                        ? () {
                          Get.toNamed(Routes.HOME);
                        }
                        : () {}, // Empty function when disabled
              ),

              const SizedBox(height: 15),
              // Secondary Sign Up button (skip address)
              Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [Colors.grey.shade50, Colors.grey.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.grey.shade300, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Get.toNamed(Routes.HOME);
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.fast_forward,
                            color: Colors.grey.shade700,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Create Account Without Store",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
