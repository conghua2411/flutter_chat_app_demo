import 'package:flutter/material.dart';
import 'package:flutter_chat_app_demo/model/chat_room_model.dart';
import 'package:flutter_chat_app_demo/model/story_model.dart';

import 'chat_bloc.dart';
import 'chat_room_screen/chat_room_screen.dart';

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatState();
}

class ChatState extends State<ChatScreen> {
  ChatBloc bloc = ChatBloc();
  TextEditingController searchTextController;

  @override
  void initState() {
    super.initState();

    searchTextController = TextEditingController();

    bloc.getListStory();
    bloc.getListChatRoom();

    searchTextController.addListener(() {
      bloc.searchChatRoom(searchTextController.text);
    });
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        color: Colors.white,
        child: _sliverList(),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: false,
      title: Text(
        'Chats',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          top: 8,
          bottom: 8,
          right: 4,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(24),
            image: DecorationImage(
              image: NetworkImage(
                'https://cdnb.artstation.com/p/assets/images/images/011/781/461/large/tiago-sousa-thu2018-v7-square.jpg?1531504014',
              ),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              print(
                'alo 1234',
              );
            },
            child: Container(
              width: 40,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                Icons.photo_camera,
                size: 20,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 4,
            top: 8,
            bottom: 8,
            right: 8,
          ),
          child: GestureDetector(
            onTap: () {
              print(
                'alo 1234',
              );
            },
            child: Container(
              width: 40,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                Icons.edit,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _sliverList() {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _buildSearch(),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _buildStory(),
            ],
          ),
        ),
        _buildListChatRoomSliver(),
      ],
    );
  }

  _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromRGBO(0, 0, 0, 0.2),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Icon(
                Icons.search,
                size: 20,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: TextField(
                  controller: searchTextController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Search',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildStory() {
    return Container(
      height: 100,
      child: StreamBuilder<List<StoryModel>>(
          initialData: [],
          stream: bloc.bsListStory,
          builder: (context, snapshot) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildAddMyStory();
                } else {
                  return Container(
                    width: 86,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      snapshot.data[index - 1].imageUrl,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.white,
                                      ),
                                      color: Colors.amber),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            snapshot.data[index - 1].user.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
              itemCount: snapshot.data.length + 1,
            );
          }),
    );
  }

  _buildAddMyStory() {
    return Container(
      width: 86,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                borderRadius: BorderRadius.circular(26),
              ),
              child: Icon(Icons.add),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'Your story',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  _buildListChatRoomSliver() {
    return StreamBuilder<List<ChatRoomModel>>(
      initialData: [],
      stream: bloc.bsListChatRoom,
      builder: (context, snapshot) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return _buildChatRoomItem(snapshot.data[index]);
            },
            childCount: snapshot.data.length,
          ),
        );
      },
    );
  }

  _buildChatRoomItem(ChatRoomModel chatRoomModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatRoomScreen(
                    chatRoomModel: chatRoomModel,
                  )));
        },
        child: Container(
          height: 80,
          child: Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: NetworkImage(
                              chatRoomModel.roomImageUrl,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 1,
                      ),
                      child: Text(
                        '${_diffDateByNow(chatRoomModel.lastMessage.date)}m',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber[100],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      chatRoomModel.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          chatRoomModel.lastMessage.id != 'me?' ? '' : 'You: ',
                        ),
                        Flexible(
                          child: Text(
                            chatRoomModel.lastMessage.message,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '- ${_getDateText(chatRoomModel.lastMessage.date)}',
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getDateText(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  _diffDateByNow(DateTime date) {
    return DateTime.now().difference(date).inMinutes;
  }
}
