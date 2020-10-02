import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/model.dart';
import '../repository/repository.dart';

class ChatDomain {
  final ChatRepository chatRepository = ChatRepository();

  Stream<QuerySnapshot> getUserChats() {
    return chatRepository.getUserChats();
  }

  Stream<QuerySnapshot> getMessages({currentUserId, selectedUserId}) {
    return chatRepository.getMessages(
      currentUserId: currentUserId,
      selectedUserId: selectedUserId,
    );
  }

  Stream<QuerySnapshot> getGlobalChats() {
    return chatRepository.getGlobalChats();
  }

  Future sendGlobalChat(String text) async {
    return await chatRepository.sendGlobalChat(text);
  }

  Future sendChat({senderUid, selectedUid, senderName, text}) async {
    return await chatRepository.sendChat(
      selectedUid: selectedUid,
      senderUid: senderUid,
      senderName: senderName,
      text: text,
    );
  }
}
