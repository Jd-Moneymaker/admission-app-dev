import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../api/firebase_chat_api.dart';
import '../../../style/style.dart';
import '../cubit/chat_cubit.dart';
import '../utils/chat_bubble.dart';

class ChatRoom extends StatefulWidget {
  final String recieverEmail;
  final String? recieverUid;
  final String chatroomId;

  const ChatRoom(
      {super.key,
      required this.recieverEmail,
      this.recieverUid,
      required this.chatroomId});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log(widget.chatroomId);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        titleSpacing: 4,
        leading: const Padding(
          padding: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Placeholder(),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.recieverEmail.split('@')[0],
                style: textBoldW,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "online now",
                    style: textSmallW,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    radius: 3,
                    backgroundColor: Color.fromARGB(255, 65, 77, 66),
                  ),
                ],
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.phone,
              size: 24,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.close,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height -
            (MediaQuery.of(context).padding.top + kToolbarHeight),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(14),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        // ! this is causing circular pogress indicator to be displayed whenever keyboard is open
                        child: provider(),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                child: TextFormField(
                                  style: textBoldW,
                                  controller: textController,
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.text,
                                  // * style for textfield
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () async {
                                        _sendText();
                                      },
                                      child: const Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),
                                    ),
                                    // * adds border radius without adding black border arounf widget
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: InputBorder.none,
                                    isDense: true,
                                    filled: true,
                                    fillColor: Colors.black,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 18, horizontal: 20),
                                    hintText: "Message...",
                                    hintStyle: textBoldW,
                                  ),
                                  // controller: cpfcontroller,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendText() async {
    if (textController.text.isNotEmpty) {
      await FirebaseChatApi.sendMessage(
          chatroomId: widget.chatroomId,
          text: textController.text,
          recieverEmail: widget.recieverEmail);
      setState(() {
        textController.clear();
      });
    }
  }

  Widget provider() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: BlocProvider(
          create: (context) => MessagesCubit(widget.chatroomId),
          child: BlocBuilder<MessagesCubit, MessagesState>(
            builder: (context, state) {
              if (state is MessagesLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is MessagesLoadedState) {
                return ListView.builder(
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final messageData = state.messages[index];
                    final isMe = (FirebaseChatApi.currentUserEmail ==
                        messageData['reciever']);
                    final ts = messageData['time'].toDate();
                    final formattedDate = DateFormat.jm().format(ts);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: ChatBubble(
                        isMe: isMe,
                        message: messageData['text'],
                        time: formattedDate,
                      ),
                    );
                  },
                );
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
        ),
      );
}
