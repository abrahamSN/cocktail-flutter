import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ChatGlobalEvent extends Equatable {
  const ChatGlobalEvent();
}

class ChatGlobalFetching extends ChatGlobalEvent {
  @override
  List<Object> get props => [];
}
