import 'dart:math';

import 'package:flutter_chat_app_demo/core/base_bloc.dart';
import 'package:flutter_chat_app_demo/model/chat_room_model.dart';
import 'package:flutter_chat_app_demo/model/message_model.dart';
import 'package:flutter_chat_app_demo/model/story_model.dart';
import 'package:flutter_chat_app_demo/model/user_model.dart';
import 'package:flutter_chat_app_demo/util/util_test_data.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class ChatBloc extends BaseBloc {
  final bsListStory = BehaviorSubject<List<StoryModel>>();
  final bsListChatRoom = BehaviorSubject<List<ChatRoomModel>>();

  List<ChatRoomModel> listChatRoomBackup = List();

  void getListStory() {
    Future.delayed(
      Duration(seconds: 2),
      () {
        var uuid = new Uuid();
        List<StoryModel> listStory = List();
        for (int i = 0; i < 20; i++) {
          StoryModel storyModel = StoryModel(
            id: uuid.v1(),
            storyType: StoryType.IMAGE,
            imageUrl: TestImageList[i % (TestImageList.length)],
            user: UserModel(
              id: uuid.v1(),
              name: uuid.v1(),
              email: 'alo@loa.com',
              image: TestImageList[i % (TestImageList.length)],
            ),
          );
          listStory.add(storyModel);
        }

        bsListStory.add(listStory);
      },
    );
  }

  void getListChatRoom() {
    Random random = Random();
    Future.delayed(
      Duration(seconds: 2),
      () {
        var uuid = new Uuid();
        listChatRoomBackup = List();
        for (int i = 0; i < 20; i++) {
          ChatRoomModel chatRoomModel = ChatRoomModel(
            id: uuid.v1(),
            name: uuid.v1(),
            roomImageUrl: TestImageList[i % (TestImageList.length)],
            lastMessage: MessageModel(
                id: uuid.v1(),
                message: uuid.v1(),
                date: DateTime.now().subtract(
                  Duration(
                    minutes: random.nextInt(60),
                    seconds: random.nextInt(60),
                  ),
                ),
                user: UserModel(
                  id: uuid.v1(),
                  name: uuid.v1(),
                  email: 'email',
                  image: TestImageList[i % (TestImageList.length)],
                )),
          );
          listChatRoomBackup.add(chatRoomModel);
        }
        bsListChatRoom.add(listChatRoomBackup);
      },
    );
  }

  @override
  dispose() {
    bsListStory.close();
    bsListChatRoom.close();
  }

  void searchChatRoom(String text) {
    bsListChatRoom.add(listChatRoomBackup.where((chatRoom) {
      return chatRoom.name.contains(text);
    }).toList());
  }
}
