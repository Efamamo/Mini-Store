import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final String text;
  const Separator({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              decoration: const BoxDecoration(color: Colors.grey),
            ),
          ),
          const SizedBox(width: 30),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Container(
              height: 1,
              decoration: const BoxDecoration(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
