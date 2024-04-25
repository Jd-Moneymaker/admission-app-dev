// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatRoomModel {
  String? chatRoomId;
  // *
  Map<String, dynamic>? participants;
  // * can be added below username or email before entering chatroom
  String? lastMessage;

  ChatRoomModel({
    this.chatRoomId,
    this.participants,
    this.lastMessage,
  });

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatRoomId = map['chatRoomId'];
    participants = map['participants'];
    lastMessage = map['lastMessage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'chatRoomId': chatRoomId,
      'participants': participants,
      'lastMessage': lastMessage,
    };
  }
}
