import 'package:admission_app_dev/screens/profile/edit%20profile%20screen/edit_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../style/style.dart';
import '../../cubit/data_cubit.dart';
import '../../utils/profile_button.dart';
import '../../utils/profile_tabar.dart';

// ! to fix

// ! if theres no data in user document, like name bio etc app is going to crash

// ! very important

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // profileCubit.getProfileData();
    });

    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileLoaded) {
            try {
              final List<DocumentSnapshot> profileData = (state).profileData;
              for (var doc in profileData) {
                final Map<String, dynamic> data =
                    doc.data() as Map<String, dynamic>;
                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            // ! cover pic
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                color: Colors.black,
                                child: userPic(
                                  context,
                                  data['coverPic'] ?? '',
                                ),
                              ),
                            ),
                            // ! cover pic

                            // * this sits under the main content's container
                            Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 20, left: 146),
                                    child: Text(
                                      data['name'] ?? 'User',
                                      style: followersFollowingText,
                                    ),
                                  ),

                                  // ? bio
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 8),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                          minHeight: 20, maxHeight: 50),
                                      child: Text(
                                        data['bio'] ?? 'Enter bio',
                                        style: textSmallB,
                                      ),
                                    ),
                                  ),
                                  // ? bio

                                  // * buttons
                                  const ProfileButton(),
                                  // * buttons

                                  // ! main app content like the pictures

                                  const Expanded(
                                    child: ProfileTabBar(),
                                  ),

                                  // ! main app content like the pictures
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // * back button
                      Positioned(
                        top: 50,
                        right: 25,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Icon(
                                Icons.close,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditProfileScreen(data: data),
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // * close screen button and edit profile button

                      // * profile pic
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.13,
                        left: 20,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(14),
                            ),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      width: 110,
                                      height: 100,
                                      color: Colors.black,
                                      child: userPic(
                                          context, data['profilePic'] ?? ''),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      // * profile pic
                    ],
                  ),
                );
              }
            } catch (e) {
              return const Center(
                child: Text(
                  'An error occurred while feating profile details',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          }
          return const Center(
            child: Text(
              'No data',
              style: textBoldB,
            ),
          );
        },
      ),
    );
  }
}

Widget userPic(BuildContext context, String imageUrl) {
  if (imageUrl.isNotEmpty) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  } else {
    return Container();
  }
}
