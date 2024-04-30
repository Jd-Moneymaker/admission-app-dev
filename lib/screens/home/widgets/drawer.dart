import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../style/style.dart';

Widget homeScreenDrawer(BuildContext context, String url) => Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 6,
            sigmaY: 6,
          ),
          child: const SizedBox.expand(),
        ),
        Drawer(
          width: MediaQuery.of(context).size.width / 1.22,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Image.asset(
                            'assets/png/user.png',
                            color: Colors.black,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Moneymaker',
                                style: textBoldW,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '+91 9774426514',
                                style: textSmallW,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        menuItem('assets/png/document.png', 'Documents', () {}),
                        menuItem('assets/png/course.png', 'Cources', () {}),
                        menuItem('assets/png/heart.png', 'Liked', () {}),
                        menuItem('assets/png/save.png', 'Saved', () {}),
                        menuItem('assets/png/logout.png', 'Logout', () async {
                          await FirebaseAuth.instance.signOut();
                        }),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );

Widget menuItem(String icon, String title, Function()? onTap) => InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                icon,
                color: Colors.black,
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
