import 'package:flutter/material.dart';

class Landing extends StatelessWidget {
  final String image;
  final int pageIndex;
  final String title;
  final String description;

  const Landing({
    super.key,
    required this.description,
    required this.image,
    required this.pageIndex,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Stack(
        children: [
          // The Positioned widget is used to position the Row at the top
          pageIndex == 0
              ? const Positioned(
                top: 105, // Positioning the Row at the top with 120 offset
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "MINI",
                      style: TextStyle(
                        fontFamily: 'GreatVibes',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 28, 51),
                      ),
                    ),
                    SizedBox(width: 1),
                    Text(
                      ".",
                      style: TextStyle(
                        fontFamily: 'GreatVibes',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 1),
                    Text(
                      "STORE",
                      style: TextStyle(
                        fontFamily: 'GreatVibes',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 54, 5, 1),
                      ),
                    ),
                  ],
                ),
              )
              : const SizedBox(),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  height: 1.1,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Image.asset(image, width: double.infinity),
              const SizedBox(height: 16),
              // Description Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
