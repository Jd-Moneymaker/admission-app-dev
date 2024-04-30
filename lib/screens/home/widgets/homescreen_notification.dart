import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../style/style.dart';

class HomeScreenNotification extends StatelessWidget {
  const HomeScreenNotification(
      {super.key, required this.image, required this.title});

  final String image, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Stack(
        children: [
          Container(
            height: 65,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                title,
                style: textBoldW,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
