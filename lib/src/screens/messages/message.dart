import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../widgets/widgets.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Chats",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: _bodyBuilder(),
    );
  }

  Widget _bodyBuilder() {
    return BlocBuilder<MessageBloc, MessageState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is MessageFetchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MessageFetchSuccess) {
          return StreamBuilder(
            stream: state.chats,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text("No data"),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data.documents.isNotEmpty
                    ? snapshot.data.documents.length + 1
                    : 1,
                shrinkWrap: true,
                // ignore: missing_return
                itemBuilder: (BuildContext context, int index) {
                  return index == 0
                      ? ChatRoomTile(
                          name: 'Global Chat',
                          chat: 'chat for all of users',
                          time: '',
                          onPress: () {
                            context
                                .bloc<ChatGlobalBloc>()
                                .add(ChatGlobalFetching());
                            Navigator.pushNamed(context, '/chat_global');
                          },
                        )
                      : ChatRoomTile(
                          name: 'name',
                          chat: 'chat',
                          time: 'lain',
                          onPress: () {
                            context.bloc<ChatBloc>().add(ChatFetching());
                            Navigator.pushNamed(
                              context,
                              '/chat',
                              arguments: {
                                'model': 'model',
                              },
                            );
                          },
                        );
                },
              );
            },
          );
        }
        ;
      },
    );
  }
}
