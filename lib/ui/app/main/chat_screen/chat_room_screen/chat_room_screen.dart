import 'package:flutter/material.dart';
import 'package:flutter_chat_app_demo/model/chat_room_model.dart';
import 'package:flutter_chat_app_demo/model/message_model.dart';

import 'chat_room_bloc.dart';

class ChatRoomScreen extends StatefulWidget {
  final ChatRoomModel chatRoomModel;

  ChatRoomScreen({
    this.chatRoomModel,
  });

  @override
  State createState() => ChatRoomState();
}

class ChatRoomState extends State<ChatRoomScreen> {
  ChatRoomBloc chatRoomBloc = ChatRoomBloc();

  @override
  void initState() {
    super.initState();
    chatRoomBloc.getMessageChatRoomById(widget.chatRoomModel.id);
  }

  @override
  void dispose() {
    chatRoomBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildChatRoomAppBar(),
      body: Container(
        color: Colors.white,
        child: StreamBuilder<List<MessageModel>>(
          initialData: [],
          stream: chatRoomBloc.bsListMessage,
          builder: (context, snapshot) {
            return ListView.builder(
              reverse: true,
              itemBuilder: (context, index) {
                return _buildMessageItem(snapshot.data[index],
                    messageTop: index < snapshot.data.length - 1
                        ? snapshot.data[index + 1]
                        : null,
                    messageBottom:
                        index != 0 ? snapshot.data[index - 1] : null);
              },
              itemCount: snapshot.data.length,
            );
          },
        ),
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
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: NetworkImage(
                    widget.chatRoomModel.roomImageUrl,
                  ),
                  fit: BoxFit.cover,
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
            color: Colors.white,
          ),
          onPressed: () {
            print('aloo 1234');
          },
        ),
        IconButton(
          icon: Icon(
            Icons.video_call,
            color: Colors.white,
          ),
          onPressed: () {
            print('aloo 1234');
          },
        ),
      ],
    );
  }

  _buildMessageItem(
    MessageModel message, {
    MessageModel messageTop,
    MessageModel messageBottom,
  }) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: messageBottom == null
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(message.user.image),
                      fit: BoxFit.cover,
                    ),
                  )
                : BoxDecoration(
                    color: Colors.transparent,
                  ),
          ),
          SizedBox(
            width: 16,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                messageTop == null ? Text(message.user.name) : Container(),
                _buildMessage(message),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildMessage(MessageModel messageModel) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        color: Colors.grey,
      ),
      child: Text(
        messageModel.message,
      ),
    );
  }
}
