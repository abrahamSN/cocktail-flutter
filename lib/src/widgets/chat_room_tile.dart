import 'package:flutter/material.dart';

class ChatRoomTile extends StatelessWidget {
  final String name;
  final String time;
  final String chat;
  final Function onPress;

  const ChatRoomTile({Key key, this.name, this.time, this.chat, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: CircleAvatar(
        child: Text('GB'),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(
            name,
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
          new Text(
            time,
            style: new TextStyle(color: Colors.grey, fontSize: 14.0),
          ),
        ],
      ),
      subtitle: new Container(
        padding: const EdgeInsets.only(top: 5.0),
        child: new Text(
          chat,
          style: new TextStyle(color: Colors.grey, fontSize: 15.0),
        ),
      ),
    );
  }
}
