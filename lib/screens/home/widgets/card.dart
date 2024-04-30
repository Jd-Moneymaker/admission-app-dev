import 'package:admission_app_dev/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard(
      {super.key,
      required this.image,
      required this.title,
      required this.location});

  final String image;
  final String title;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(215, 255, 255, 255),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: textBoldB,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/png/map.png',
                          fit: BoxFit.contain,
                          height: 12,
                          width: 12,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(location),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
