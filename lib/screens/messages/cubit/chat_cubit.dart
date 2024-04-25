import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../api/firebase_chat_api.dart';

part 'chat_state.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
StreamSubscription<QuerySnapshot>? _chatMessagesStreamSubscription;

class ChatCubit extends Cubit<ChatState> {
  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<QuerySnapshot>? _chatRoomStreamSubscription;

  ChatCubit() : super(ChatInitial()) {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        cancelChatRoomStreamSubscription();
        log('user logged out, subscription cancelling ..');
        emit(ChatInitial());
      } else {
        if (_chatRoomStreamSubscription == null) {
          _subscribeToChatRoomStream();
        } else {
          return;
        }
      }
    });
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    cancelChatRoomStreamSubscription();
    return super.close();
  }

  void _subscribeToChatRoomStream() {
    // ! after subscription is cancelled, it gets started again, to be fixed

    log('chatroom subscription started');

    _chatRoomStreamSubscription = _firestore
        .collection("chats")
        .where("users", arrayContains: FirebaseChatApi.currentUserEmail)
        .snapshots()
        .listen(
      (QuerySnapshot snapshot) {
        final List<DocumentSnapshot> documents = snapshot.docs;
        emit(ChatRoomLoadedState(documents));
      },
      onError: (error) {
        emit(ChatErrorState(error));
      },
    );
    emit(ChatRoomLoadingState());
  }

  cancelChatRoomStreamSubscription() {
    _chatRoomStreamSubscription?.cancel();
    log('chatroom subscription cancelled');
    // ! Cancel chat room stream subscription if it exists
  }
}

class MessagesCubit extends Cubit<MessagesState> {
  final String id;
  MessagesCubit(this.id) : super(MessagesInitial()) {
    _subscribeToMessagesStream(id);
  }

  @override
  Future<void> close() {
    // ? Cancel subscription when the Cubit is closed
    _chatMessagesStreamSubscription?.cancel();
    return super.close();
  }

  // ! fetch messages - stream subscription function => part of ChatRoom file
  void _subscribeToMessagesStream(String chatroomId) {
    _chatMessagesStreamSubscription = _firestore
        .collection("chats")
        .doc(chatroomId)
        .collection("messages")
        .orderBy('time')
        .snapshots()
        .listen(
      (QuerySnapshot snapshot) {
        final List<DocumentSnapshot> documents = snapshot.docs;
        emit(MessagesLoadedState(documents));
        markMessagesAsRead(documents, chatroomId);
      },
      onError: (error) {
        emit(MessagesErrorState(error));
      },
    );
    emit(MessagesLoadingState());
  }

  // ! fetch messages - stream subscription function => part of ChatRoom file
}

class SearchUsersCubit extends Cubit<SearchUsersState> {
  SearchUsersCubit() : super(SearchUsersInitial());
  // ! search user feature => part of message screen
  void searchUsers(String searchText) {
    emit(SearchUsersLoadingState());
    try {
      _firestore
          .collection("users")
          .where('email', isEqualTo: searchText)
          .limit(10)
          .get()
          .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          List<DocumentSnapshot> searchResults = snapshot.docs.toList();
          emit(SearchUsersLoadedState(searchResults));
        }
      });
    } catch (error) {
      emit(SearchUsersErrorState(error.toString()));
      log('Error: $error');
    }
  }
  // ! search user feature => part of message screen
}
