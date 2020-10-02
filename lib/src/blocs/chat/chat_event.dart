import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class ChatFetching extends ChatEvent {
  final String currentUid, selectedName, selectedId;

  ChatFetching({this.currentUid, this.selectedId, this.selectedName});

  @override
  List<Object> get props => [currentUid, selectedId, selectedName];
}

class ChatTyping extends ChatEvent {
  final String text;

  ChatTyping({@required this.text});

  @override
  List<Object> get props => [text];
}

class ChatSending extends ChatEvent {
  final senderUid;
  final selectedUid;
  final senderName;
  final text;

  const ChatSending({
    this.senderUid,
    this.selectedUid,
    this.senderName,
    this.text,
  });

  @override
  List<Object> get props => [senderUid, selectedUid, senderName, text];
}
