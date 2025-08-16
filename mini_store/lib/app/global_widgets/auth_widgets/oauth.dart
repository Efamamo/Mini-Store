import 'package:flutter/material.dart';

class OAUTH extends StatefulWidget {
  final String name;
  final String icon;
  final Function() onPressed;
  const OAUTH({
    super.key,
    required this.name,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<OAUTH> createState() => _OAUTHState();
}

class _OAUTHState extends State<OAUTH> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: widget.onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: Image.asset(
                widget.icon,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
