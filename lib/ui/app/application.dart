import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app_demo/data/shared_preference_wapper/shared_preference_wapper.dart';
import 'package:flutter_chat_app_demo/ui/app/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

import 'application_bloc.dart';

class ChatAppDemo extends StatefulWidget {
  final SharedPreferenceWrapper sharedPreferenceWrapper;

  ChatAppDemo({
    @required this.sharedPreferenceWrapper,
  });

  @override
  State createState() => ChatAppDemoState();
}

class ChatAppDemoState extends State<ChatAppDemo> {
  ApplicationBloc applicationBloc = ApplicationBloc();

  StreamSubscription<Brightness> streamBrightness;

  Brightness appBrightness = Brightness.light;

  ChatAppDemoState() {
    applicationBloc = ApplicationBloc();

    streamBrightness = applicationBloc.bsThemeBrightness.listen((brightness) {
      setState(() {
        appBrightness = brightness;
      });
    }, onError: (e) {
      print('bsThemeBrightness: error - $e');
    });
  }

  @override
  void dispose() {
    streamBrightness.cancel();
    applicationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter_chat_app_demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        brightness: appBrightness,
      ),
      home: _provideModule(),
    );
  }

  _provideModule() {
    return MultiProvider(
      providers: [
        Provider<SharedPreferenceWrapper>.value(
            value: widget.sharedPreferenceWrapper),
        Provider<ApplicationBloc>.value(value: applicationBloc),
      ],
      child: SplashScreen(),
    );
  }
}
