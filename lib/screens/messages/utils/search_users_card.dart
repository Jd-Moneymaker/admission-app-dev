import 'package:flutter/material.dart';

import '../../../style/style.dart';

class SearchUsersCard extends StatelessWidget {
  final Map<String, dynamic> searchdata;
  const SearchUsersCard({super.key, required this.searchdata});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        children: [
          // * profile pic
          Container(
            height: 60,
            width: 55,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          // * profile pic

          // * name and message
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  searchdata['email'],
                  style: textBoldB,
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'online now',
                  style: textSmallB,
                ),
              ],
            ),
          ),
          // * name and message
        ],
      ),
    );
  }
}
