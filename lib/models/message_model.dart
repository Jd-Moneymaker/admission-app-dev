// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? messageId;
  String? sender;
  String? reciever;
  String? text;
  bool? seen;
  int? unseenMessageCount;
  Timestamp? time;
  MessageModel({
    this.messageId,
    this.sender,
    this.reciever,
    this.text,
    this.seen,
    this.unseenMessageCount,
    this.time,
  });

  MessageModel.fromMap(Map<String, dynamic> map) {
    messageId = map['messageId'];
    sender = map['sender'];
    reciever = map['reciever'];
    text = map['text'];
    seen = map['seen'];
    unseenMessageCount = map['unseenMessageCount'];
    time = map['time'];
  }

  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'sender': sender,
      'reciever': reciever,
      'text': text,
      'seen': seen,
      'unseenMessageCount': unseenMessageCount,
      'time': time,
    };
  }
}

class LastMessageModel {
  String? chatroomId;
  String? reciever;
  String? sender;
  String? lastMessage;
  bool? seen;
  Timestamp? time;

  LastMessageModel({
    this.sender,
    this.reciever,
    this.chatroomId,
    this.lastMessage,
    this.seen,
    this.time,
  });

  LastMessageModel.fromMap(Map<String, dynamic> map) {
    chatroomId = map['chatroomId'];
    sender = map['sender'];
    reciever = map['reciever'];
    lastMessage = map['lastMessage'];
    time = map['time'];
    seen = map['seen'];
  }

  Map<String, dynamic> toMap() {
    return {
      'chatroomId': chatroomId,
      'sender': sender,
      'reciever': reciever,
      'lastMessage': lastMessage,
      'time': time,
      'seen': seen,
    };
  }
}
