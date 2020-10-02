import 'package:equatable/equatable.dart';

import '../../data/model/model.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatFetchLoading extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatFetchSuccess extends ChatState {
  final chats;

  const ChatFetchSuccess({this.chats});

  @override
  List<Object> get props => [chats];
}

class ChatFetchError extends ChatState {
  final String error;

  const ChatFetchError({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Something wrongs: { error: $error }';
}

class ChatTypeSuccess extends ChatState {
  final chatsfield;

  const ChatTypeSuccess({this.chatsfield});

  @override
  List<Object> get props => [chatsfield];
}

class ChatSend extends ChatState {
  final senderUid;
  final selectedUid;
  final senderName;
  final text;

  const ChatSend({
    this.senderUid,
    this.selectedUid,
    this.senderName,
    this.text,
  });

  @override
  List<Object> get props => [senderUid, selectedUid, senderName, text];
}
