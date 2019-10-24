import 'dart:math';

import 'package:flutter_chat_app_demo/core/base_bloc.dart';
import 'package:flutter_chat_app_demo/model/message_model.dart';
import 'package:flutter_chat_app_demo/model/user_model.dart';
import 'package:flutter_chat_app_demo/util/util_test_data.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class ChatRoomBloc extends BaseBloc {
  BehaviorSubject<List<MessageModel>> bsListMessage = BehaviorSubject();

  void getMessageChatRoomById(String id) {
    Random random = Random();
    Future.delayed(
      Duration(seconds: 2),
      () {
        List<MessageModel> listMessageModel = List();
        for (int i = 0; i < 20; i++) {
          var uuid = new Uuid();
          MessageModel messageModel = MessageModel(
            id: uuid.v1(),
            type: MessageType.Text,
            message: 'message ${uuid.v1()}',
            date: DateTime.now().subtract(
              Duration(
                minutes: random.nextInt(60),
                seconds: random.nextInt(60),
              ),
            ),
            user: UserModel(
              id: uuid.v1(),
              name: '$i',
              email: 'email 123',
              image: TestImageList[i % (TestImageList.length)],
            ),
          );
          listMessageModel.add(messageModel);
        }

        bsListMessage.add(listMessageModel);
      },
    );
  }

  @override
  dispose() {
    bsListMessage.close();
  }
}
