import 'package:bloc/bloc.dart';

import './chat_event.dart';
import './chat_state.dart';

import '../../data/domain/domain.dart';
import '../../data/model/model.dart';

export './chat_event.dart';
export './chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatDomain chatDomain = ChatDomain();

  ChatBloc() : super(ChatFetchLoading());

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatFetching) {
      yield ChatFetchLoading();

      try {
        final currentUserId = event.props[0];
        final selectedUserId = event.props[1];
        final senderName = event.props[2];

        final resChat = await chatDomain.getMessages(
          currentUserId: currentUserId,
          selectedUserId: selectedUserId,
        );
        yield ChatFetchSuccess(chats: resChat);
      } catch (e) {
        yield ChatFetchError(error: e.toString());
      }
    } else if (event is ChatSending) {
      final senderUid = event.props[0];
      final selectedUid = event.props[1];
      final senderName = event.props[2];
      final text = event.props[3];

      chatDomain.sendChat(
        senderUid: senderUid,
        selectedUid: selectedUid,
        senderName: senderName,
        text: text,
      );
      yield ChatSend(
        senderUid: senderUid,
        selectedUid: selectedUid,
        senderName: senderName,
        text: text,
      );
    }
  }
}
