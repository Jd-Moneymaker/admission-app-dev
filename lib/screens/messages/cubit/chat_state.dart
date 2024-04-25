part of 'chat_cubit.dart';

abstract class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatUsersLoadingState extends ChatState {}

final class ChatUsersLoadedState extends ChatState {
  final DocumentSnapshot searchResults;

  ChatUsersLoadedState(this.searchResults);
}

final class ChatRoomLoadingState extends ChatState {}

final class ChatRoomLoadedState extends ChatState {
  final List<DocumentSnapshot> chatroomData;

  ChatRoomLoadedState(this.chatroomData);
}

class ChatErrorState extends ChatState {
  final String error;
  ChatErrorState(this.error);
}

abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

final class MessagesLoadingState extends MessagesState {}

final class MessagesLoadedState extends MessagesState {
  final List<DocumentSnapshot> messages;

  MessagesLoadedState(this.messages);
}

class MessagesErrorState extends MessagesState {
  final String error;
  MessagesErrorState(this.error);
}

abstract class SearchUsersState {}

class SearchUsersInitial extends SearchUsersState {}

final class SearchUsersLoadingState extends SearchUsersState {}

final class SearchUsersLoadedState extends SearchUsersState {
  final List<DocumentSnapshot> searchResults;

  SearchUsersLoadedState(this.searchResults);
}

class SearchUsersErrorState extends SearchUsersState {
  final String error;
  SearchUsersErrorState(this.error);
}
