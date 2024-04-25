import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../style/style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('message_screen');
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: const Center(
                    child: Text(
                      'Messages',
                      style: textSmallW,
                    ),
                  ),
                ),
              ),
            ),

            // ! logout
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: const Center(
                    child: Text(
                      'Logout',
                      style: textSmallW,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
