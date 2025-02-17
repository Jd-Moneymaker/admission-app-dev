import 'dart:math';

import 'package:flutter/material.dart';

import 'utils/login_signin_tab.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    log(size.height);

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      // ! makes the screen scrollable when typing forms. it removes overflow problem
      body: SingleChildScrollView(
        // ! very important. column needs to be given a fixed height when its inside a scroll view
        child: SizedBox(
          height: size.height,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.38,
                child: Padding(
                  padding: const EdgeInsets.only(top: 80, bottom: 40),
                  child: Image.asset(
                    'assets/png_assets/auth icon.png',
                  ),
                ),
              ),
              // ! main content of screen.
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Container(
                  height: size.height * 0.6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                      bottomLeft: Radius.circular(26),
                      bottomRight: Radius.circular(26),
                    ),
                  ),
                  // * container styling
                  child: const LoginSigninTabBar(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
