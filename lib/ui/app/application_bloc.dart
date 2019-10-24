import 'dart:ui';

import 'package:flutter_chat_app_demo/core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ApplicationBloc extends BaseBloc {
  final BehaviorSubject<Brightness> bsThemeBrightness =
      BehaviorSubject<Brightness>();

  changeThemeBrightness(Brightness brightness) {
    bsThemeBrightness.add(brightness);
  }

  @override
  dispose() {
    bsThemeBrightness.close();
  }
}
