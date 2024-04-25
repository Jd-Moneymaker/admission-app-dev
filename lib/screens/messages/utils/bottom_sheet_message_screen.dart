import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../api/firebase_chat_api.dart';
import '../chat-room/chat_room.dart';
import 'search_users_card.dart';

// ! Function to show the bottom sheet with search results
void showSearchResultsBottomSheet(
    BuildContext context, final List<DocumentSnapshot> searchResults) {
  for (var doc in searchResults) {
    final Map<String, dynamic> searchResultData =
        doc.data() as Map<String, dynamic>;

    final isMe =
        (FirebaseChatApi.currentUserEmail == searchResultData['email']);

    Map<String, dynamic> chatRoomInfoMap = {
      "users": [FirebaseChatApi.currentUserEmail, searchResultData['email']],
    };
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.74,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
              ),
              child: isMe
                  ? const Center(
                      child: Text('Users not found'),
                    )
                  : GestureDetector(
                      onTap: () {
                        List<String> ids = [
                          searchResultData['uid'],
                          FirebaseChatApi.currentUserId.toString()
                        ];
                        ids.sort();
                        String chatroomId = ids.join('-');

                        FirebaseChatApi.createChatRoom(
                            searchResultData['uid'], chatRoomInfoMap);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatRoom(
                              recieverEmail: searchResultData['email'],
                              recieverUid: searchResultData['uid'],
                              chatroomId: chatroomId,
                            ),
                          ),
                        );
                      },
                      child: SearchUsersCard(searchdata: searchResultData),
                    )),
        );
      },
    );
  }
}
