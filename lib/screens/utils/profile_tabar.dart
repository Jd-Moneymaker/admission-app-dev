import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../style/style.dart';
import '../home/widgets/card.dart';
import 'document_card.dart';

class ProfileTabBar extends StatelessWidget {
  const ProfileTabBar({super.key});

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3, // Number of tabs
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 30),
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
                  Tab(text: 'Posts'),
                  Tab(text: 'Documents'),
                  Tab(text: 'Courses'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Content for Tab 1
                  Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(15, 0, 0, 0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                ),
                                width: MediaQuery.of(context).size.width * 0.43,
                                height: 120,
                                margin: const EdgeInsets.only(left: 10),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(15, 0, 0, 0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                ),
                                width: MediaQuery.of(context).size.width * 0.43,
                                height: 120,
                                margin: const EdgeInsets.only(left: 10),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(15, 0, 0, 0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                ),
                                width: MediaQuery.of(context).size.width * 0.43,
                                height: 120,
                                margin: const EdgeInsets.only(left: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Container(
                          height: 200,
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                        ),
                      )
                    ],
                  ),

                  // Content for Tab 2
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        DocumentCard(
                          title: 'Marksheets',
                          description: 'your previous years marksheets',
                        ),
                        DocumentCard(
                          title: 'Student Id',
                          description:
                              'your ducuments like birth certificate, aadhaar',
                        ),
                        DocumentCard(
                          title: 'Payment',
                          description: 'screenshot of application form payment',
                        ),
                      ],
                    ),
                  ),
                  // ! Content for Tab 3
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15, left: 20, right: 20),
                    child: CarouselCard(
                      image: 'assets/colleges/1.jpeg',
                      title: 'St Anthonys College',
                      location: 'Laitumkhrah, Shillong',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
