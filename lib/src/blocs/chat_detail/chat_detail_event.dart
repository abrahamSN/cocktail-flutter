import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model.dart';


abstract class ChatDetailEvent extends Equatable {
  const ChatDetailEvent();
}

class ChatDetailFetching extends ChatDetailEvent {
  @override
  List<Object> get props => [];
}

class ChatDetailTyping extends ChatDetailEvent {
  final String text;

  ChatDetailTyping({@required this.text});

  @override
  List<Object> get props => [text];
}

class ChatDetailSending extends ChatDetailEvent {
  final senderUid;
  final selectedUid;
  final senderName;
  final text;

  const ChatDetailSending({
    this.senderUid,
    this.selectedUid,
    this.senderName,
    this.text,
  });

  @override
  List<Object> get props => [senderUid, selectedUid, senderName, text];
}
