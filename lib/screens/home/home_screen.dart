import 'dart:ui';

import 'package:admission_app_dev/style/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../homepage/widgets/cource_slider.dart';
import '../homepage/widgets/institute_card.dart';

final TextEditingController _searchController = TextEditingController();

String url = 'assets/png/search.png';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), // Adjust the
              color: Colors.black,
            ),
            child: BottomAppBar(
              height: 65,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/png/home.png',
                    color: Colors.white,
                  ),
                  Image.asset(
                    'assets/png/heart.png',
                    color: Colors.white,
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed('message_screen'),
                    child: Image.asset(
                      'assets/png/message.png',
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed('profile_screen'),
                    child: Image.asset(
                      'assets/png/user.png',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: homeScreenDrawer(context, url),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 65, left: 20, right: 20),
                    child: Column(
                      children: [
                        // ! heading and drawer icon
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello Moneymaker,',
                                  style: textBoldW,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'What can we do for u today ?',
                                  style: textBoldW,
                                ),
                              ],
                            ),
                            Builder(builder: (context) {
                              return SizedBox(
                                child: GestureDetector(
                                  onTap: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  child: Image.asset(
                                    'assets/png/menu-right.png',
                                    color: Colors.white,
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                        // ! heading and drawer icon

                        const SizedBox(
                          height: 30,
                        ),

                        // ! searchField

                        TextFormField(
                          controller: _searchController,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            suffixIcon: Image.asset('assets/png/search.png'),
                            fillColor: Colors.white,
                            isDense: true,
                            filled: true,
                            hintText: 'Search',
                            hintStyle: textBoldB,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 15),
                          ),
                        )

                        // ! searchField
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        // ! course type slider
                        SizedBox(
                          height: 60,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              CourceSlider(
                                title: 'Science',
                                image: 'assets/png/science.png',
                              ),
                              CourceSlider(
                                title: 'Commerce',
                                image: 'assets/png/commerce.png',
                              ),
                              CourceSlider(
                                title: 'Arts',
                                image: 'assets/png/arts.png',
                              ),
                            ],
                          ),
                        ),
                        // ! course type slider

                        // ! main feed => cources , posts , ads
                        SizedBox(
                          height: 415,
                          child: Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: const [
                                InstituteCard(
                                  title: 'Lady Kean College',
                                  description:
                                      'Popular cources include BA, Bcom,Bttm ..',
                                  url: 'assets/colleges/lady kean college.jpg',
                                ),
                                InstituteCard(
                                  title: 'St Mary\'s College',
                                  description:
                                      'Popular cources incluse Ba, Bcom, Mcom..',
                                  url: 'assets/colleges/smc.jpg',
                                ),
                                InstituteCard(
                                  title: 'Shillong College',
                                  description:
                                      'Popular cources incluse Ba, BBA, Bcom ..',
                                  url: 'assets/colleges/shillong college.jpg',
                                ),
                              ],
                            ),
                          ),
                        ),
                        // ! main feed => cources , posts , ads
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

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
