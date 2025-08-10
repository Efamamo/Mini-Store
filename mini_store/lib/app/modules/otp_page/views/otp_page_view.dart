import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/otp_page_controller.dart';
import '../../../global_widgets/auth_widgets/welcome.dart';

class OtpPageView extends GetView<OtpPageController> {
  const OtpPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F7F1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Welcome(
              headText: "Enter Otp",
              subText: "Verify your identity with the OTP sent to you.",
              image: "assets/icons/otp.png",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 36,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      controller: controller.controllers[index],
                      focusNode: controller.focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      onChanged: (value) {
                        controller.handleInput(value, index);
                        if (value.isEmpty && index > 0) {
                          controller.handleBackspace(value, index);
                        }
                      },
                      onEditingComplete: () {
                        if (index < 3) {
                          controller.focusNodes[index + 1].requestFocus();
                        }
                      },
                      decoration: InputDecoration(
                        counterText: "", // Removes the character counter
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        suffixIcon:
                            controller.controllers[index].text.isNotEmpty
                                ? IconButton(
                                  icon: const Icon(Icons.clear, size: 18),
                                  onPressed: () {
                                    controller.controllers[index].clear();
                                    controller.focusNodes[index].requestFocus();
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                )
                                : null,
                      ),
                    ),
                  );
                }),
              ),
            ),
            // Add a clear button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: controller.clearOTP,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Clear OTP',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
