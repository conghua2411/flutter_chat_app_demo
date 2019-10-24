import 'package:flutter_chat_app_demo/model/user_model.dart';

import 'message_model.dart';

class ChatRoomModel {
  String id;
  String name;
  String roomImageUrl;
  MessageModel lastMessage;
  bool isOnline;
  List<UserModel> listUser;

  ChatRoomModel({
    this.id,
    this.name,
    this.roomImageUrl,
    this.lastMessage,
    this.isOnline,
    this.listUser,
  });
}
