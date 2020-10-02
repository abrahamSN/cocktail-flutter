import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../widgets/widgets.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController _messageTextController = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _messageTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${args['selectedName']}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {
              Navigator.pushNamed(context, '/call_page');
            },
          ),
        ],
      ),
      body: _bodyBuilder(context, args),
    );
  }

  Widget _bodyBuilder(BuildContext context, args) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: BlocBuilder<ChatBloc, ChatState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is ChatFetchLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ChatFetchSuccess) {
                    return StreamBuilder(
                      stream: state.chats,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("No data"),
                          );
                        }
                        if (snapshot.data.documents.isNotEmpty) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.documents.length,
                            shrinkWrap: true,
                            // ignore: missing_return
                            itemBuilder: (BuildContext context, int index) {
                              if (snapshot.data.documents.isNotEmpty) {
                                return ChatWidget(
                                  isGlobal: true,
                                  currentUserId:
                                      FirebaseAuth.instance.currentUser.uid,
                                  messageId:
                                      snapshot.data.documents[index].documentID,
                                );
                              }
                            },
                          );
                        }
                        return Center(
                          child: Text("Wanna start the conversation ?"),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(),
                boxShadow: [BoxShadow(blurRadius: 1.0)]),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _messageTextController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    if (_messageTextController.text != '') {
                      context.bloc<ChatDetailBloc>().add(
                            ChatDetailSending(
                                selectedUid: args['selectedId'],
                                senderUid:
                                    FirebaseAuth.instance.currentUser.uid,
                                senderName: FirebaseAuth
                                    .instance.currentUser.displayName,
                                text: _messageTextController.text),
                          );
                      _messageTextController.clear();
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
