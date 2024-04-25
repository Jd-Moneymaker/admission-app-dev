import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../style/style.dart';
import '../cubit/profile_cubit.dart';

// ! to fix

// ! if theres no data in user document, like name bio etcapp is going to crash

// ! very important

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileCubit.getProfileData();
    });

    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileLoaded) {
            final List<DocumentSnapshot> profileData = (state).profileData;

            for (var doc in profileData) {
              final Map<String, dynamic> data =
                  doc.data() as Map<String, dynamic>;

              return Stack(
                children: [
                  Column(
                    children: [
                      // ! cover pic
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black,
                          child: userPic(context, data['coverPic']),
                        ),
                      ),
                      // ! cover pic

                      // * this sits under the main content's container
                      Container(
                        height: MediaQuery.of(context).size.height * 0.78,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 24, left: 146),
                                  child: Text(
                                    data['name'],
                                    style: followersFollowingText,
                                  ),
                                ),
                              ],
                            ),

                            // ? bio
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      minHeight: 50, maxHeight: 55),
                                  child: Center(child: Text(data['bio'])),
                                )),
                            // ? bio

                            // * buttons
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Container(
                                height: 64,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 175,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Add friend',
                                            style: textSmallB,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 60,
                                        width: 175,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Message',
                                            style: textSmallW,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // * buttons

                            // ! main app content like the pictures
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(14))),
                                ),
                              ),
                            ),
                            // ! main app content like the pictures
                          ],
                        ),
                      ),
                    ],
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
                          onTap: () => Navigator.of(context)
                              .pushNamed('edit_profile_screen'),
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
                    top: MediaQuery.of(context).size.height * 0.15,
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
                                  child: userPic(context, data['profilePic']),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                  // * profile pic
                ],
              );
            }
          }
          return Container();
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
