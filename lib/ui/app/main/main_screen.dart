import 'package:flutter/material.dart';

import 'chat_screen/chat_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State createState() => MainState();
}

/// image data
/// https://cdnb.artstation.com/p/assets/images/images/011/781/461/large/tiago-sousa-thu2018-v7-square.jpg?1531504014
/// https://cdnb.artstation.com/p/assets/images/images/014/529/497/large/chun-lo-spider-man.jpg?1544367716
/// https://cdnb.artstation.com/p/assets/images/images/008/994/291/large/chun-lo-astro01.jpg?1516546998
/// https://cdna.artstation.com/p/assets/images/images/018/357/216/large/alena-aenami-horizon-1k.jpg?1559071156
/// https://cdna.artstation.com/p/assets/images/images/009/970/322/large/alena-aenami-lines1k.jpg?1521834310
/// https://cdnb.artstation.com/p/assets/images/images/012/298/143/large/alena-aenami-cold-1k.jpg?1534082874
/// https://cdnb.artstation.com/p/assets/images/images/007/198/563/large/alena-aenami-eclipse-1k.jpg?1504395238
/// https://cdna.artstation.com/p/assets/images/images/002/263/182/large/alena-aenami-coldredlight.jpg?1459458204
/// https://cdnb.artstation.com/p/assets/images/images/001/884/753/large/alena-aenami-zakat2200.jpg?1457873599
/// https://cdna.artstation.com/p/assets/images/images/002/486/498/large/alena-aenami-mountains2k.jpg?1462312397
/// https://cdna.artstation.com/p/assets/images/images/001/793/794/large/alena-aenami-revenant2-2-1.jpg?1452811928
/// https://cdna.artstation.com/p/assets/images/images/001/798/518/large/alena-aenami-revenant3-2.jpg?1452975563

class MainState extends State<MainScreen> with SingleTickerProviderStateMixin {
  TabController _mainPageTabController;

  @override
  void initState() {
    super.initState();

    _mainPageTabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: TabBarView(
          controller: _mainPageTabController,
          children: [
            ChatScreen(),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.blue,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: SafeArea(
          child: TabBar(
            controller: _mainPageTabController,
            indicatorColor: Colors.transparent,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                icon: Icon(Icons.chat),
              ),
              Tab(
                icon: Icon(Icons.people),
              ),
              Tab(
                icon: Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
