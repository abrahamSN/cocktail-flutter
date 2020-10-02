import 'package:bloc/bloc.dart';

import './chat_detail_event.dart';
import './chat_detail_state.dart';

import '../../data/domain/domain.dart';
import '../../data/model/model.dart';

export './chat_detail_event.dart';
export './chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  final ChatDomain chatDomain = ChatDomain();

  ChatDetailBloc() : super(ChatDetailFetchLoading());

  @override
  Stream<ChatDetailState> mapEventToState(ChatDetailEvent event) async* {
    if (event is ChatDetailSending) {
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

      yield ChatDetailSend(
        senderUid: senderUid,
        selectedUid: selectedUid,
        senderName: senderName,
        text: text,
      );
    }
  }
}
