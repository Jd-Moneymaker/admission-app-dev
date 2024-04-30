import 'package:flutter/material.dart';
import 'package:admission_app_dev/style/style.dart';

class CourceSlider extends StatelessWidget {
  final String image;
  final String title;
  const CourceSlider({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10),
      child: SizedBox(
        width: 135,
        child: Card(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                image,
                color: Colors.white,
                fit: BoxFit.cover,
                height: 24,
                width: 24,
              ),
              Text(
                title,
                style: textSmallW,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
