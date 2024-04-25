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
    String userId,
    String name,
    String username,
    String bio,
  ) async {
    final Map<String, dynamic> profileData = {
      'name': name,
      'username': username,
      'bio': bio,
    };

    try {
      await _firestore.collection("users").doc(userId).update(profileData);
      log('Updated $userId profile details');
    } catch (error) {
      log('Error marking message as read: $error');
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
