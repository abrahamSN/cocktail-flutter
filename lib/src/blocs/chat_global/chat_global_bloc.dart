import 'package:bloc/bloc.dart';

import './chat_global_event.dart';
import './chat_global_state.dart';

import '../../data/domain/domain.dart';
import '../../data/model/model.dart';

export './chat_global_event.dart';
export './chat_global_state.dart';

class ChatGlobalBloc extends Bloc<ChatGlobalEvent, ChatGlobalState> {
  final ChatDomain chatDomain = ChatDomain();

  ChatGlobalBloc() : super(ChatGlobalFetchLoading());

  @override
  Stream<ChatGlobalState> mapEventToState(ChatGlobalEvent event) async* {
    if (event is ChatGlobalFetching) {
      yield ChatGlobalFetchLoading();

      try {
        final resChat = await chatDomain.getGlobalChats();
        yield ChatGlobalFetchSuccess(chats: resChat);
      } catch (e) {
        yield ChatGlobalFetchError(error: e.toString());
      }
    }
  }
}
