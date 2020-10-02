import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model.dart';


abstract class ChatGlobalDetailEvent extends Equatable {
  const ChatGlobalDetailEvent();
}

class ChatGlobalDetailFetching extends ChatGlobalDetailEvent {
  @override
  List<Object> get props => [];
}

class ChatGlobalDetailTyping extends ChatGlobalDetailEvent {
  final String text;

  ChatGlobalDetailTyping({@required this.text});

  @override
  List<Object> get props => [text];
}

class ChatGlobalDetailSending extends ChatGlobalDetailEvent {
  final String text;

  ChatGlobalDetailSending({@required this.text});

  @override
  List<Object> get props => [text];
}
