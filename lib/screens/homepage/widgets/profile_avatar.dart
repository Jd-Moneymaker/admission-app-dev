import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      child: const CircleAvatar(
        radius: 40,
        backgroundColor: Colors.black,
        child: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
    );
  }
}
