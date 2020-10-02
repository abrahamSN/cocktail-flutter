import 'package:equatable/equatable.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();
}

class MessageFetching extends MessageEvent {
  final String uid;

  MessageFetching({this.uid});

  @override
  List<Object> get props => [uid];

}