import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import '../models/message_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirebaseChatApi {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static String? currentUserId;
  static String? currentUserEmail;
  static String? chatroomId;

  static void loadUserData() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        currentUserId = user.uid;
        currentUserEmail = user.email;
        log('User signed in as: $currentUserEmail');
      } else {
        // User is signed out
        currentUserId = null;
        currentUserEmail = null;
        log('User signed out');
      }
    });
  }

  // ! send message and update last message function if users have interacted before
  static sendMessage({
    required String text,
    required String recieverEmail,
    required String chatroomId,
  }) async {
    //  ? important to get values of sender & reciever
    final ts = Timestamp.now();

    String messageId = randomAlphaNumeric(10);
    //  ? important to get values of sender & reciever

    // ? user models to map data to firestore
    final message = MessageModel(
      messageId: messageId,
      time: ts,
      seen: false,
      unseenMessageCount: 1,
      sender: currentUserEmail,
      reciever: recieverEmail,
      text: text,
    );
    final lastMessage = LastMessageModel(
      chatroomId: chatroomId,
      time: ts,
      sender: currentUserEmail,
      reciever: recieverEmail,
      lastMessage: text,
      seen: false,
    );
    // ? user models to map data to firestore

    final Map<String, dynamic> lastMessageData = lastMessage.toMap();
    lastMessageData['unseenMessageCount'] = FieldValue.increment(1);

    try {
      // ! adds new message to chat
      await _firestore
          .collection("chats")
          .doc(chatroomId)
          .collection("messages")
          .doc(messageId)
          .set(message.toMap());
      log('Message sent successfully. ChatroomId is : $chatroomId');
      // ! Updates the last message in chat
      await _firestore
          .collection("chats")
          .doc(chatroomId)
          .update(lastMessageData);
      log('Last message is updated successfully. ChatroomId is : $chatroomId');
    } catch (error) {
      log('Error sending message: $error');
      // Handle errors here
    }
  }
  // ! send message and update last message function

  // ! marks messages as read in firebase when user opens chatroom. => it works wit the function above
  Future<void> markAsRead(
    String messageId,
    String chatroomId,
  ) async {
    try {
      final messageRef = _firestore
          .collection("chats")
          .doc(chatroomId)
          .collection("messages")
          .doc(messageId);
      await messageRef.update({'seen': true});
      await _firestore
          .collection("chats")
          .doc(chatroomId)
          .update({'seen': true, 'unseenMessageCount': 0});
      log('Message marked as read: $messageId');
    } catch (error) {
      log('Error marking message as read: $error');
      // Handle error as needed
    }
  }
  // ! marks messages as read in firebase when user opens chatroom

  static createChatRoom(
    String recieverUid,
    Map<String, dynamic> chatRoomInfoMap,
  ) async {
    List<String> ids = [recieverUid, currentUserId!];
    ids.sort();
    String chatroomId = ids.join('-');

    final snapshot = await FirebaseFirestore.instance
        .collection("chats")
        .doc(chatroomId)
        .get();
    if (snapshot.exists) {
      return true;
    } else {
      return FirebaseFirestore.instance
          .collection("chats")
          .doc(chatroomId)
          .set(chatRoomInfoMap);
    }
  }
}

// * **************************
// ! widgets for the code above
// * **************************
// ! part of => getChatMessages
void markMessagesAsRead(
    List<DocumentSnapshot> messages, String chatroomId) async {
  // ? loops every message
  for (int i = 0; i < messages.length; i++) {
    final message = messages[i];
    final data = message.data() as Map<String, dynamic>;
    final bool seen = data['seen'] ?? false;
    final String senderEmail = data['sender'];

    if (!seen && senderEmail != FirebaseChatApi.currentUserEmail) {
      await FirebaseChatApi().markAsRead(message.id, chatroomId);
    }
  }
}

// * **************************
// ! widgets for the code above
// * **************************
