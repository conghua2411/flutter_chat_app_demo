import 'package:flutter_chat_app_demo/model/user_model.dart';

enum MessageType {Text, Image, Video}

class MessageModel {
  String id;
  MessageType type;
  String message;
  DateTime date;
  UserModel user;

  MessageModel({
    this.id,
    this.type,
    this.message,
    this.date,
    this.user,
  });
}
