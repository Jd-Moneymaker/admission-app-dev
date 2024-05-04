import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/data_cubit.dart';
import '../../profile/profile screen/profile_screen.dart';

Widget bottomAppbar(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/png/home.png',
              color: Colors.white,
            ),
            Image.asset(
              'assets/png/compass.png',
              color: Colors.white,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('message_screen'),
              child: Image.asset(
                'assets/png/message.png',
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider<ProfileCubit>(
                    create: (context) =>
                        ProfileCubit(), // Create your ProfileCubit
                    child: const ProfileScreen(),
                  ),
                ),
              ),
              child: Image.asset(
                'assets/png/user.png',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
