import 'package:flutter/material.dart';

import '../../style/style.dart';

class DocumentCard extends StatelessWidget {
  const DocumentCard({
    super.key,
    required this.title,
    required this.description,
  });

  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(15, 0, 0, 0),
          borderRadius: BorderRadius.all(Radius.circular(14))),
      width: MediaQuery.of(context).size.width * 0.45,
      height: 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.image,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: textBoldB,
            ),
            Text(
              description,
              style: textSmallB,
            )
          ],
        ),
      ),
    );
  }
}
