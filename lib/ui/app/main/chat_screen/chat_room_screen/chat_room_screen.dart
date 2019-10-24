import 'package:flutter/material.dart';
import 'package:flutter_chat_app_demo/model/chat_room_model.dart';

class ChatRoomScreen extends StatefulWidget {
  final ChatRoomModel chatRoomModel;

  ChatRoomScreen({
    this.chatRoomModel,
  });

  @override
  State createState() => ChatRoomState();
}

class ChatRoomState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildChatRoomAppBar(),
      body: Container(
      ),
    );
  }

  _buildChatRoomAppBar() {
    return AppBar(
      title: Container(
        height: double.infinity,
        child: Row(
          children: <Widget>[
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: NetworkImage(
                    widget.chatRoomModel.roomImageUrl,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Flexible(
              child: Text(
                widget.chatRoomModel.name,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.phone,
            color: Colors.blue,
          ),
          onPressed: () {
            print('aloo 1234');
          },
        ),
        IconButton(
          icon: Icon(
            Icons.video_call,
            color: Colors.blue,
          ),
          onPressed: () {
            print('aloo 1234');
          },
        ),
      ],
    );
  }
}
