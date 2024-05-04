import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../api/firebase_auth_api.dart';
import '../../../style/style.dart';
import '../../utils/get_user_pics.dart';
import '../../utils/profile_textfield.dart';
import 'helper/image_uploader.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final String currentUserId = firebaseAuth.currentUser!.uid;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController bioController = TextEditingController();

  final String userId = firebaseAuth.currentUser!.uid;

  String? _selectedGender;
  DateTime? _selectedDate;

  void _onGenderSelected(String selectedGender) {
    setState(() {
      _selectedGender = selectedGender;
    });
  }

  void _onDateSelected(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: const UploadUserImage(
                    width: double.infinity,
                    coverPic: true,
                  ),
                ),
                // * this sits under the main content's container
                Container(
                  height: MediaQuery.of(context).size.height * 0.78,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 55),
                    child: Column(
                      children: [
                        ProfileTextField(
                          controller: nameController,
                          hintText: widget.data['name'] != null &&
                                  widget.data['name'].isNotEmpty
                              ? widget.data['name']
                              : 'Enter your name',
                          title: 'Name',
                          type: 'name',
                        ),

                        ProfileTextField(
                          controller: usernameController,
                          hintText: widget.data['username'] != null &&
                                  widget.data['username'].isNotEmpty
                              ? widget.data['username']
                              : 'Enter username',
                          title: 'Username',
                          type: 'username',
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DropDownSelector(
                                title: 'Gender',
                                hintText: widget.data['gender'] != null &&
                                        widget.data['gender'].isNotEmpty
                                    ? widget.data['gender']
                                    : 'Enter gender',
                                onGenderSelected: _onGenderSelected,
                              ),
                              DateSelector(
                                title: 'Date of birth',
                                onDateSelected: _onDateSelected,
                              )
                            ],
                          ),
                        ),

                        ProfileTextField(
                          controller: bioController,
                          hintText: widget.data['bio'] != null &&
                                  widget.data['bio'].isNotEmpty
                              ? widget.data['bio']
                              : 'Enter bio',
                          title: 'Bio',
                          type: 'bio',
                        ),

                        const Spacer(),

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
                                  GestureDetector(
                                    onTap: () {
                                      FirebaseApi().updateProfile(
                                        userId: userId,
                                        name: nameController.text,
                                        username: usernameController.text,
                                        bio: bioController.text,
                                        gender: _selectedGender,
                                        dob: _selectedDate,
                                      );

                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: 60,
                                      width: 165,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Save',
                                          style: textSmallB,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.of(context).pop(),
                                    child: Container(
                                      height: 60,
                                      width: 165,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Cancel',
                                          style: textSmallW,
                                        ),
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

                        // ! main app content like the pictures
                      ],
                    ),
                  ),
                ),
              ],
            ),

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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 110,
                      height: 100,
                      color: Colors.black,
                      child: const UploadUserImage(
                        width: 110,
                        height: 100,
                        coverPic: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // * profile pic
          ],
        ),
      ),
    );
  }
}
