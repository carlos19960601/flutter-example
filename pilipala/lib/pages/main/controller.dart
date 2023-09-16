import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/pages/dynamics/view.dart';
import 'package:pilipala/pages/home/view.dart';
import 'package:pilipala/pages/media/view.dart';
import 'package:pilipala/utils/utils.dart';

class MainController extends GetxController {
  List<Widget> pages = <Widget>[
    const HomePage(),
    const DynamicsPage(),
    const MediaPage(),
  ];

  RxList navigationBars = [
    {
      "icon": const Icon(
        Icons.favorite_outline,
        size: 21,
      ),
      "selectIcon": const Icon(
        Icons.favorite,
        size: 21,
      ),
      'label': "首页",
    },
    {
      'icon': const Icon(
        Icons.motion_photos_on_outlined,
        size: 21,
      ),
      'selectIcon': const Icon(
        Icons.motion_photos_on,
        size: 21,
      ),
      'label': "动态",
    },
    {
      'icon': const Icon(
        Icons.folder_outlined,
        size: 20,
      ),
      'selectIcon': const Icon(
        Icons.folder,
        size: 21,
      ),
      'label': "媒体库",
    }
  ].obs;

  final StreamController<bool> bottomBarStream = StreamController.broadcast();
  DateTime? _lastPressedAt;

  @override
  void onInit() {
    super.onInit();
    Utils.checkUpdate();
  }

  bool onBackPressed() {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt!) >
            const Duration(seconds: 2)) {
      _lastPressedAt = DateTime.now();

      return false; // 不退出应用
    }

    return true; //退出应用
  }
}
