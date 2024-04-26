import 'package:flutter/material.dart';

import '../../style/style.dart';
import 'widgets/burger_menu.dart';
import 'widgets/cource_slider.dart';
import 'widgets/drawer.dart';
import 'widgets/greeting.dart';
import 'widgets/search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  String url = 'https://placehold.jp/150x150.png';

// ! clears text from search field
  void _clearTextField() {
    _searchController.clear();
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ! app drawer
      drawer: const HomepageDrawer(),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Greeting(),
                      // ! shows app drawer
                      Builder(
                        builder: (context) => const HambergerMenu(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  HomepageSearchField(
                    controller: _searchController,
                    hintText: 'Search...',
                    prefix: const Icon(Icons.search),
                    // ! hides clear button from search field. and shows it whenn text is entered
                    onPressed: () => _clearTextField(),
                  ),
                ],
              ),
            ),
          ),
          // * cource slider
          // ! listview always need a container/sixedbox with height
          SizedBox(
            height: 80,
            child: Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CourceSlider(
                    title: 'Science',
                    image: url,
                  ),
                  CourceSlider(
                    title: 'Commerce',
                    image: url,
                  ),
                  CourceSlider(
                    title: 'Arts',
                    image: url,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          // * Home page body
          // ! listview always need a container/sixedbox with height
          SizedBox(
            height: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Popular institutes',
                    style: textBoldB,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
