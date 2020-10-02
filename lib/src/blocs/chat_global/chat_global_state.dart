import 'package:equatable/equatable.dart';

import '../../data/model/model.dart';

abstract class ChatGlobalState extends Equatable {
  const ChatGlobalState();
}

class ChatGlobalFetchLoading extends ChatGlobalState {
  @override
  List<Object> get props => [];
}

class ChatGlobalFetchSuccess extends ChatGlobalState {
  final chats;

  const ChatGlobalFetchSuccess({this.chats});

  @override
  List<Object> get props => [chats];
}

class ChatGlobalFetchError extends ChatGlobalState {
  final String error;

  const ChatGlobalFetchError({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Something wrongs: { error: $error }';
}

class ChatGlobalTypeSuccess extends ChatGlobalState {
  final chatsfield;

  const ChatGlobalTypeSuccess({this.chatsfield});

  @override
  List<Object> get props => [chatsfield];
}