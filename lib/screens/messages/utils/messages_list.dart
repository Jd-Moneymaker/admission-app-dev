import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../api/firebase_chat_api.dart';
import '../../../style/style.dart';
import '../chat-room/chat_room.dart';
import '../cubit/chat_cubit.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({
    super.key,
  });

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
// ! to enable refresh please check gpt chat history

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatRoomLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ChatRoomLoadedState) {
            try {
              // Return ListView.builder and call markMessagesAsRead
              return ListView.builder(
                itemCount: state.chatroomData.length,
                itemBuilder: (context, index) {
                  final document = state.chatroomData[index];
                  return _buildMessageCard(document, context);
                },
              );
            } catch (e) {
              return const Center(
                child: Text(
                  'An error occurred while building the messages.',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          } else {
            return const Center(
              child: Text(
                'No messages',
                style: textBoldB,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildMessageCard(DocumentSnapshot document, BuildContext context) {
    Map<String, dynamic> messageData = document.data()! as Map<String, dynamic>;

    // ! to fix if messageData is not null, but data inside the document is null then toDate() and other text widgets crashes the app
    var ts = messageData['time']?.toDate();
    String formattedDate = '';
    if (ts != null) {
      final formattedDate = DateFormat.jm().format(ts);
    } else {
      const formattedDate = 'Unknown';
    }

    final isMe = (FirebaseChatApi.currentUserEmail == messageData['reciever']);

    final seen = messageData['seen'];

    log('last message seen status: $seen');

    List<dynamic> users = messageData['users'];
    String otherUser = users.firstWhere(
        (user) => user != FirebaseChatApi.currentUserEmail,
        orElse: () => '');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoom(
                recieverEmail: otherUser,
                chatroomId: messageData['chatroomId'],
              ),
            ),
          );
        },
        child: Row(
          children: [
            // * profile pic
            Container(
              height: 65,
              width: 60,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ),
            // * profile pic

            // * name and message
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          otherUser.split('@')[0].toString(),
                          style: textSmallBoldB,
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: messageData['seen'] == false && isMe
                              ? Container(
                                  height: 17,
                                  width: 17,
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3))),
                                  child: Center(
                                    child: Text(
                                      messageData['unseenMessageCount']
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ),
                                )
                              : Container(),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        // ! last message
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.54),
                          child: Text(
                            messageData['lastMessage'] ?? 'send new message',
                            style: messageData['seen'] == false && isMe
                                ? textBoldB
                                : textSmallB,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // ! last message
                        const Spacer(),
                        // ! last message time
                        Text(
                          formattedDate,
                          style: const TextStyle(fontSize: 11),
                        ),
                        // ! last message time
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // * name and message
          ],
        ),
      ),
    );
  }
}
