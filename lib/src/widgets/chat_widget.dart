import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../data/model/model.dart';
import '../data/repository/chat_repository.dart';


class ChatWidget extends StatefulWidget {
  final bool isGlobal;
  final String messageId, currentUserId;

  ChatWidget({this.isGlobal, this.messageId, this.currentUserId});

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  ChatRepository _repository = new ChatRepository();

  MessageModel _chat;

  Future getDetails() async {
    _chat = await _repository.getMessageGlobalChatDetail(
        messageId: widget.messageId);

    return _chat;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ChatBloc _chat = BlocProvider.of<ChatBloc>(context);

    return FutureBuilder(
      future: getDetails(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return Container();
        } else {
          return Column(
            crossAxisAlignment: snap.data.senderId == widget.currentUserId
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: <Widget>[
              snap.data.text != null
                  ? Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      children: <Widget>[
                        snap.data.senderId == widget.currentUserId
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.01),
                                child: Text(
                                  snap.data.timeStamp.toDate().hour.toString() +
                                      ":" +
                                      snap.data.timeStamp
                                          .toDate()
                                          .minute
                                          .toString(),
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: EdgeInsets.all(size.height * 0.01),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: size.width * 0.7,
                            ),
                            child: InkWell(
                              onTap: () {
                                if (!widget.isGlobal) {
                                  return null;
                                }
                                if (snap.data.senderId ==
                                    widget.currentUserId) {
                                  return null;
                                } else {
                                  context.bloc<ChatBloc>().add(ChatFetching());
                                  return Navigator.popAndPushNamed(
                                    context,
                                    '/chat',
                                    arguments: {
                                      'currentUid' : widget.currentUserId,
                                      'selectedName': snap.data.senderName,
                                      'selectedId': snap.data.senderId,
                                    },
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      snap.data.senderId == widget.currentUserId
                                          ? Colors.grey[700]
                                          : Colors.grey[400],
                                  borderRadius:
                                      snap.data.senderId == widget.currentUserId
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  size.height * 0.02),
                                              topRight: Radius.circular(
                                                  size.height * 0.02),
                                              bottomLeft: Radius.circular(
                                                  size.height * 0.02))
                                          : BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  size.height * 0.02),
                                              topRight: Radius.circular(
                                                  size.height * 0.02),
                                              bottomRight: Radius.circular(
                                                  size.height * 0.02),
                                            ),
                                ),
                                padding: EdgeInsets.all(size.height * 0.01),
                                child: Column(
                                  crossAxisAlignment:
                                      snap.data.senderId == widget.currentUserId
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                  children: [
                                    snap.data.senderId != widget.currentUserId
                                        ? Text(
                                            snap.data.senderName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: snap.data.senderId ==
                                                      widget.currentUserId
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    Text(
                                      snap.data.text,
                                      style: TextStyle(
                                        color: snap.data.senderId ==
                                                widget.currentUserId
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        snap.data.senderId == widget.currentUserId
                            ? SizedBox()
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.01,
                                ),
                                child: Text(
                                  snap.data.timeStamp.toDate().hour.toString() +
                                      ":" +
                                      snap.data.timeStamp
                                          .toDate()
                                          .minute
                                          .toString(),
                                ),
                              ),
                      ],
                    )
                  : Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      children: <Widget>[
                        snap.data.senderId == widget.currentUserId
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.01),
                                child: Text(snap.data.timeStamp
                                        .toDate()
                                        .hour
                                        .toString() +
                                    ":" +
                                    snap.data.timeStamp
                                        .toDate()
                                        .minute
                                        .toString()),
                              )
                            : Container(),
                        snap.data.senderId == widget.currentUserId
                            ? SizedBox()
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.01),
                                child: Text(
                                  snap.data.timeStamp.toDate().hour.toString() +
                                      ":" +
                                      snap.data.timeStamp
                                          .toDate()
                                          .minute
                                          .toString(),
                                ),
                              ),
                      ],
                    ),
            ],
          );
        }
      },
    );
  }
}
