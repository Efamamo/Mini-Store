import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback ontap;

  const AuthButton({super.key, required this.widget, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.blue,
        ),
        onPressed: ontap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: widget,
        ),
      ),
    );
  }
}
