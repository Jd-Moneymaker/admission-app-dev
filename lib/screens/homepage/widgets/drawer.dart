import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../style/style.dart';

class HomepageDrawer extends StatefulWidget {
  const HomepageDrawer({super.key});

  @override
  State<HomepageDrawer> createState() => _HomepageDrawerState();
}

class _HomepageDrawerState extends State<HomepageDrawer> {
  @override
  Widget build(BuildContext context) => Drawer(
        width: MediaQuery.of(context).size.width / 1.22,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black,
                width: double.infinity,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Moneymaker',
                        style: textBoldB,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '+91 9774426514',
                        style: textSmallB,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    profileItem(
                      'assets/png/edit_user_icon.png',
                      'Max Kharkongor',
                      // ! navigates to profile screen.
                      () => Navigator.popAndPushNamed(context, 'profilePage'),
                    ),
                    // profileItem('assets/png/arts.png', 'Add account', () {}),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Divider(
                        color: Colors.black,
                        height: 2.4,
                      ),
                    ),
                    menuItem('assets/png/cource_icon.png', 'Cources', () {}),
                    menuItem('assets/png/like_icon.png', 'Liked', () {}),
                    menuItem('assets/png/save_icon.png', 'Saved', () {}),
                    menuItem('assets/png/logout_icon.png', 'Logout',
                        () => signOut()),
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Widget profileItem(String icon, String title, Function()? onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Image(
                image: AssetImage(
                  icon,
                ),
                fit: BoxFit.contain,
                height: 30,
                width: 30,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 4,
              child: Text(
                title,
                style: textSmallB,
              ),
            ),
          ]),
        ),
      );

  Widget menuItem(String icon, String title, Function()? onTap) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image(
                  image: AssetImage(
                    icon,
                  ),
                  fit: BoxFit.contain,
                  height: 30,
                  width: 30,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 4,
                child: Text(
                  title,
                  style: textSmallB,
                ),
              ),
            ],
          ),
        ),
      );

  Future signOut() async {
    FirebaseAuth.instance.signOut();
  }
}
