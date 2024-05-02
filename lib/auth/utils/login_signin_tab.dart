import 'package:admission_app_dev/auth/signin/signin.dart';
import 'package:flutter/material.dart';

import '../../style/style.dart';
import '../login/login.dart';

class LoginSigninTabBar extends StatelessWidget {
  const LoginSigninTabBar({super.key});

  @override
  Widget build(BuildContext context) => const DefaultTabController(
        length: 2, // Number of tabs
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: TabBar(
                labelStyle: tabBarText,
                labelColor: Colors.black,
                dividerColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                ),
                tabs: [
                  Tab(text: 'Login'),
                  Tab(text: 'Signup'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Content for Tab 1
                  Login(),

                  // Content for Tab 2
                  SignIn(),
                  // Content for Tab 3
                ],
              ),
            ),
          ],
        ),
      );
}
