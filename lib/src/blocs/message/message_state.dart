import 'package:equatable/equatable.dart';

import '../../data/model/model.dart';

abstract class MessageState extends Equatable {
  const MessageState();
}

class MessageFetchLoading extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageFetchSuccess extends MessageState {
  final chats;

  const MessageFetchSuccess({this.chats});

  @override
  List<Object> get props => [chats];
}

class MessageFetchError extends MessageState {
  final String error;

  const MessageFetchError({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Something wrongs: { error: $error }';
}
