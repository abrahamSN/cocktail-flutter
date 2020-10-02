import 'package:bloc/bloc.dart';

import './chat_global_detail_event.dart';
import './chat_global_detail_state.dart';

import '../../data/domain/domain.dart';
import '../../data/model/model.dart';

export './chat_global_detail_event.dart';
export './chat_global_detail_state.dart';

class ChatGlobalDetailBloc extends Bloc<ChatGlobalDetailEvent, ChatGlobalDetailState> {
  final ChatDomain chatDomain = ChatDomain();

  ChatGlobalDetailBloc() : super(ChatGlobalDetailFetchLoading());

  @override
  Stream<ChatGlobalDetailState> mapEventToState(ChatGlobalDetailEvent event) async* {
    if (event is ChatGlobalDetailSending) {
      final field = event.props[0];
      chatDomain.sendGlobalChat(field);
      yield ChatGlobalDetailSend(chatsfield: field);
    }
  }
}
