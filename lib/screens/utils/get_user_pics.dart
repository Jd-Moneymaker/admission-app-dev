import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final String currentUserId = firebaseAuth.currentUser!.uid;

class GetUserPics extends StatelessWidget {
  final bool coverPic;

  const GetUserPics({
    super.key,
    required this.coverPic,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: getData(), // Call the getData function to fetch data
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (snapshot.hasData) {
          DocumentSnapshot<Map<String, dynamic>>? data = snapshot.data;
          final imagetype = coverPic == true ? 'coverPic' : 'profilePic';
          final imageUrl = data?.data()?[imagetype] ?? '';

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
        } else {
          return Container();
        }
      },
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(currentUserId)
          .get();

      return snapshot;
    } catch (e) {
      rethrow;
    }
  }
}
