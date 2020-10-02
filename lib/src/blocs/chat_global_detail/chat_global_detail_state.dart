import 'package:equatable/equatable.dart';

import '../../data/model/model.dart';

abstract class ChatGlobalDetailState extends Equatable {
  const ChatGlobalDetailState();
}

class ChatGlobalDetailFetchLoading extends ChatGlobalDetailState {
  @override
  List<Object> get props => [];
}

class ChatGlobalDetailFetchSuccess extends ChatGlobalDetailState {
  final chats;

  const ChatGlobalDetailFetchSuccess({this.chats});

  @override
  List<Object> get props => [chats];
}

class ChatGlobalDetailFetchError extends ChatGlobalDetailState {
  final String error;

  const ChatGlobalDetailFetchError({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Something wrongs: { error: $error }';
}

class ChatGlobalDetailTypeSuccess extends ChatGlobalDetailState {
  final chatsfield;

  const ChatGlobalDetailTypeSuccess({this.chatsfield});

  @override
  List<Object> get props => [chatsfield];
}

class ChatGlobalDetailSend extends ChatGlobalDetailState {
  final chatsfield;

  const ChatGlobalDetailSend({this.chatsfield});

  @override
  List<Object> get props => [chatsfield];
}
