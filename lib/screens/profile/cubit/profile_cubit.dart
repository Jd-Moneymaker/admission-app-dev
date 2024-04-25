import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../api/firebase_chat_api.dart';

part 'profile_state.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    getProfileData();
  }

  void getProfileData() {
    String? uid = FirebaseChatApi.currentUserId;
    String? email = FirebaseChatApi.currentUserEmail;

    try {
      _firestore.collection("users").doc(uid).get().then((snapshot) {
        if (snapshot.exists) {
          List<DocumentSnapshot> profileData = [snapshot];
          emit(ProfileLoaded(profileData));
          log('user profile data is coming for $email');
        }
      });
    } catch (error) {
      emit(ProfileError(error.toString()));
      log('Error: $error');
    }
  }
}
