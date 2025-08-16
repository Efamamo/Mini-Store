import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthToggle extends StatelessWidget {
  final String message;
  final String to;
  final String toText;
  const AuthToggle({
    super.key,
    required this.message,
    required this.to,
    required this.toText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 5),
          TextButton(
            style: TextButton.styleFrom(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(0),
            ),
            onPressed: () {
              Get.toNamed(to);
            },
            child: Text(
              toText,
              style: const TextStyle(
                color: const Color(0xFF3B82F6),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
