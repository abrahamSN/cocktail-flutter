import 'package:equatable/equatable.dart';

import '../../data/model/model.dart';

abstract class ChatDetailState extends Equatable {
  const ChatDetailState();
}

class ChatDetailFetchLoading extends ChatDetailState {
  @override
  List<Object> get props => [];
}

class ChatDetailFetchSuccess extends ChatDetailState {
  final chats;

  const ChatDetailFetchSuccess({this.chats});

  @override
  List<Object> get props => [chats];
}

class ChatDetailFetchError extends ChatDetailState {
  final String error;

  const ChatDetailFetchError({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Something wrongs: { error: $error }';
}

class ChatDetailTypeSuccess extends ChatDetailState {
  final chatsfield;

  const ChatDetailTypeSuccess({this.chatsfield});

  @override
  List<Object> get props => [chatsfield];
}

class ChatDetailSend extends ChatDetailState {
  final senderUid;
  final selectedUid;
  final senderName;
  final text;

  const ChatDetailSend({
    this.senderUid,
    this.selectedUid,
    this.senderName,
    this.text,
  });

  @override
  List<Object> get props => [senderUid, selectedUid, senderName, text];
}
