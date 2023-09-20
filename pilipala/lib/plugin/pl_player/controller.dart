import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlPlayerController {
  // 添加一个私有静态变量来保存实例
  static PlPlayerController? _instance;

  final Rx<int> _playerCount = 0.obs;

  PlPlayerController._() {}

  static PlPlayerController getInstance({
    String videoType = 'archive',
    List<BoxFit> fits = const [
      BoxFit.contain,
      BoxFit.cover,
      BoxFit.fill,
      BoxFit.fitHeight,
      BoxFit.fitWidth,
      BoxFit.scaleDown
    ],
  }) {
    // 如果实例尚未创建，则创建一个新实例
    _instance ??= PlPlayerController._();
    _instance!._playerCount.value += 1;
    return _instance!;
  }
}
