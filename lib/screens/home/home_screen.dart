import 'package:admission_app_dev/screens/home/widgets/bottom_appbar.dart';
import 'package:admission_app_dev/style/style.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'widgets/card.dart';
import 'widgets/drawer.dart';
import 'widgets/homescreen_notification.dart';

final TextEditingController _searchController = TextEditingController();

String url = 'assets/png/search.png';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      // ? drawer
      drawer: homeScreenDrawer(context, url),
      // ? drawer
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ! top container holds welcome text, menu , and search field
              Container(
                height: MediaQuery.of(context).size.height * 0.264,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 55, left: 20, right: 20),
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
                          suffixIcon: Image.asset(
                            'assets/png/slider.png',
                          ),
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
              // ! top container holds welcome text, menu , and search field

              // ! bottom container => holds popolur heading and image carousel
              Container(
                height: MediaQuery.of(context).size.height * 0.736,
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeScreenNotification(
                      image: 'assets/blur/blur.jpg',
                      title: 'Check your application status',
                    ),
                    // ? heading
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 45, vertical: 8),
                        child: Text(
                          'Popular destinations',
                          style: textBoldB,
                        )),
                    // ? heading

                    // ? main feed => cources
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 360,
                          enableInfiniteScroll: true,
                          autoPlay: false,
                          enlargeCenterPage:
                              true, // Make the center image larger
                        ),
                        items: const [
                          CarouselCard(
                            image: 'assets/colleges/1.jpeg',
                            title: 'St Anthonys College',
                            location: 'Laitumkhrah, Shillong',
                          ),
                          CarouselCard(
                            image: 'assets/colleges/2.jpeg',
                            title: 'Cheng Park',
                            location: 'Gangtok, Sikkim',
                          ),
                          CarouselCard(
                            image: 'assets/colleges/3.jpeg',
                            title: 'Starbucks',
                            location: 'Siliguri, West bengal',
                          ),
                          CarouselCard(
                            image: 'assets/colleges/4.jpeg',
                            title: 'Cathedral',
                            location: 'Laitumkhrah, Shillong',
                          ),
                        ],
                      ),
                    ),
                    // ? main feed => cources
                    const Spacer(),
                    // ! cannot use bottomAppbar in scaffold because it sticks to keyboard
                    bottomAppbar(context),
                  ],
                ),
              ),
              // ! bottom container => holds popolur heading and image carousel
            ],
          ),
        ),
      ));
}
