import 'package:bloc/bloc.dart';

import './message_event.dart';
import './message_state.dart';

import '../../data/domain/domain.dart';
import '../../data/model/model.dart';

export './message_event.dart';
export './message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final ChatDomain chatDomain = ChatDomain();

  MessageBloc() : super(MessageFetchLoading());

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is MessageFetching) {
      yield MessageFetchLoading();

      try {
        final resChat = await chatDomain.getUserChats();
        yield MessageFetchSuccess(chats: resChat);
      } catch (e) {
        yield MessageFetchError(error: e.toString());
      }
    }
  }
}
