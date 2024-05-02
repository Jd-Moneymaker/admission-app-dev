import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirebaseApi {
  // ! save user
  saveUser(AuthModel userData) async {
    await _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(userData.toJson());
  }

  // ! update user
  updateUser(UserModel userData) async {
    await _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update(userData.toMap());
  }

  Future<void> updateProfile(
      {required String userId,
      String? name,
      String? username,
      String? bio,
      String? gender,
      DateTime? dob}) async {
    final Map<String, dynamic> profileData = {};

    if (name != null && name.isNotEmpty) {
      profileData['name'] = name;
    }
    if (username != null && username.isNotEmpty) {
      profileData['username'] = username;
    }
    if (bio != null && bio.isNotEmpty) {
      profileData['bio'] = bio;
    }
    if (gender != null && gender.isNotEmpty) {
      profileData['gender'] = gender;
    }
    if (dob != null) {
      profileData['dob'] = dob;
    }

    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .update(profileData);
      log('Updated $userId profile details');
    } catch (error) {
      log('Error updating profile: $error');
      // Handle error as needed
    }
  }

  // ! delete user
  Future<void> deleteUser(String documentId) async {
    await _firestore.collection("users").doc(documentId).delete();
  }

  // Future<List<UserModel>> retieveUsers() async {
  //   QuerySnapshot<Map<String, dynamic>> snapshot =
  //       await _db.collection("users").get();
  //   return snapshot.docs
  //       .map((docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot))
  //       .toList();
  // }
}
