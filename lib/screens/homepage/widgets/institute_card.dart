import 'package:flutter/material.dart';
import 'package:admission_app_dev/style/style.dart';

class InstituteCard extends StatelessWidget {
  final String title;
  final String description;
  final String url;

  const InstituteCard({
    super.key,
    required this.title,
    required this.description,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.12,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(4, 8), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textBoldB,
                    ),
                    Text(
                      description,
                      style: textBoldB,
                    ),
                    SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // ? location icon and distance
                              Image.asset(
                                'assets/png/map.png',
                                fit: BoxFit.cover,
                                height: 18,
                                width: 18,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                '15 km away',
                                style: textSmallB,
                              ),
                              // ? location icon and distance
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
