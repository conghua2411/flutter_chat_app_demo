import 'package:flutter_chat_app_demo/model/user_model.dart';

enum StoryType { IMAGE, VIDEO }

class StoryModel {
  String id;
  StoryType storyType;
  String imageUrl;
  String videoUrl;
  UserModel user;

  StoryModel({
    this.id,
    this.storyType,
    this.imageUrl,
    this.videoUrl,
    this.user,
  });
}
