import 'package:flutter/material.dart';

import '../../post/post.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
  });

  final String image;
  final String title;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Posts(image: image)));
          },
          child: Hero(
            transitionOnUserGestures: true,
            tag: image,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(215, 255, 255, 255),
                borderRadius: BorderRadius.circular(8),
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
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
                    ),
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
