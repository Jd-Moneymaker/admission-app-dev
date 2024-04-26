import 'package:flutter/material.dart';

import '../../../style/style.dart';

class Greeting extends StatelessWidget {
  const Greeting({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, Moneymaker',
          style: textBoldW,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Start searching for an institute or cource\nyou're interested in .. ",
          style: textSmallW,
        ),
      ],
    );
  }
}
