import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agora_rtm/agora_rtm.dart';

import '../model/model.dart';

class ChatRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getUserChats() {
    try {
      final uid = _firebaseAuth.currentUser.uid;

      final res = _db
          .collection('users')
          .doc(uid)
          .collection('chats')
          .orderBy('timestamp', descending: false)
          .snapshots();

      return res;
    } catch (e) {
      return e;
    }
  }

  Stream<QuerySnapshot> getGlobalChats() {
    try {
      final res = _db
          .collection("global-chat")
          .orderBy("timestamp", descending: false)
          .snapshots();

      return res;
    } catch (e) {
      return e;
    }
  }

  Future<MessageModel> getLastMessage({currentUserId, selectedUserId}) async {
    MessageModel _message = new MessageModel();

    await _db
        .collection('users')
        .doc(currentUserId)
        .collection('chats')
        .doc(selectedUserId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .first
        .then((doc) async {
      await _db
          .collection('messages')
          .doc(doc.docs.first.id)
          .get()
          .then((message) {
        _message.text = message['text'];
        _message.timeStamp = message['timestamp'];
      });
    });

    return _message;
  }

  Stream<QuerySnapshot> getMessages({currentUserId, selectedUserId}) {
    return _db
        .collection('users')
        .doc(currentUserId)
        .collection('chats')
        .doc(selectedUserId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future sendChat({senderUid, selectedUid, senderName, text}) async {
    try {
      DocumentReference messageRef =
          _db.collection('messages').doc();

      CollectionReference senderRef = _db
          .collection('users')
          .doc(senderUid)
          .collection('chats')
          .doc(selectedUid)
          .collection('messages');

      CollectionReference sendUserRef = _db
          .collection('users')
          .doc(selectedUid)
          .collection('chats')
          .doc(senderUid)
          .collection('messages');

      if (text != null) {
        await messageRef.set({
          'sendername': senderName,
          'senderid': senderUid,
          'text': text,
          'timestamp': DateTime.now(),
        });

        senderRef
            .doc(messageRef.id)
            .set({'timestamp': DateTime.now()});

        sendUserRef
            .doc(messageRef.id)
            .set({'timestamp': DateTime.now()});

        await _db
            .collection('users')
            .doc(senderUid)
            .collection('chats')
            .doc(selectedUid)
            .update({'timestamp': DateTime.now()});

        await _db
            .collection('users')
            .doc(selectedUid)
            .collection('chats')
            .doc(senderUid)
            .update({'timestamp': DateTime.now()});
      }
    } catch (e) {
      return e;
    }
  }

  Future sendGlobalChat(String text) async {
    try {
      DocumentReference msgRef = _db.collection('global-chat').doc();
      await msgRef.set({
        'sendername': _firebaseAuth.currentUser.displayName,
        'senderid': _firebaseAuth.currentUser.uid,
        'text': text,
        'timestamp': DateTime.now()
      });
    } catch (e) {
      return e;
    }
  }

  Future getMessageGlobalChatDetail({messageId}) async {
    try {
      MessageModel _message = MessageModel();
      DocumentReference msgRef = _db.collection('global-chat').doc(messageId);

      await msgRef.get().then((msg) {
        _message.senderId = msg['senderid'];
        _message.senderName = msg['sendername'];
        _message.timeStamp = msg['timestamp'];
        _message.text = msg['text'];
      });

      return _message;
    } catch (e) {
      return e;
    }
  }
}
