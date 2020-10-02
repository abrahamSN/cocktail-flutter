import 'package:cocktail_flutter/src/blocs/blocs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/widgets.dart';

class ChatGlobal extends StatefulWidget {
  @override
  _ChatGlobalState createState() => _ChatGlobalState();
}

class _ChatGlobalState extends State<ChatGlobal> {
  TextEditingController _messageTextController = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _messageTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats Global",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: _bodyBuilder(context),
    );
  }

  Widget _bodyBuilder(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: BlocBuilder<ChatGlobalBloc, ChatGlobalState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is ChatGlobalFetchLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ChatGlobalFetchSuccess) {
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
                      context.bloc<ChatGlobalDetailBloc>().add(
                            ChatGlobalDetailSending(
                              text: _messageTextController.text,
                            ),
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
