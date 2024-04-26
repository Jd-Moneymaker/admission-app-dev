import 'package:flutter/material.dart';

class HambergerMenu extends StatelessWidget {
  const HambergerMenu({super.key});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: const Icon(
          Icons.menu,
          size: 30,
          color: Colors.white,
        ),
      );
}
