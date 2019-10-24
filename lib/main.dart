import 'package:flutter/material.dart';
import 'package:flutter_chat_app_demo/ui/app/application.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/shared_preference_wapper/shared_preference_wapper.dart';

void main() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  SharedPreferenceWrapper sharedPreferenceWrapper = SharedPreferenceWrapper(
    prefs: sharedPreferences,
  );

  return runApp(
    ChatAppDemo(
      sharedPreferenceWrapper: sharedPreferenceWrapper,
    ),
  );
}
