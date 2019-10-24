import 'package:flutter/material.dart';
import 'package:flutter_chat_app_demo/ui/app/main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State createState() => SplashState();
}

class SplashState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Splash screen',
        ),
      ),
    );
  }

  _checkLogin() {
    Future.delayed(Duration(seconds: 2), () {
      _gotoMain();
    });
  }

  _gotoMain() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => MainScreen()));
  }
}
