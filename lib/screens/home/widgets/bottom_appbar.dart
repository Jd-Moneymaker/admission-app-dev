import 'package:flutter/material.dart';

Widget bottomAppbar(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/png/home.png',
              color: Colors.white,
            ),
            Image.asset(
              'assets/png/compass.png',
              color: Colors.white,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('message_screen'),
              child: Image.asset(
                'assets/png/message.png',
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('profile_screen'),
              child: Image.asset(
                'assets/png/user.png',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
