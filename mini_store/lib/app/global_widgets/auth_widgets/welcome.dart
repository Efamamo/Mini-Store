import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  final String image;
  final String headText;
  final String subText;
  const Welcome({
    super.key,
    required this.headText,
    required this.subText,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return AppName(headText: headText, subText: subText, image: image);
  }
}

class AppName extends StatelessWidget {
  final String headText;
  final String subText;
  final String image;
  const AppName({
    super.key,
    required this.headText,
    required this.subText,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 80, bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 100, child: Image.asset(image)),
          const SizedBox(height: 10),
          Text(
            headText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 5),
          Text(subText, style: const TextStyle()),
        ],
      ),
    );
  }
}
