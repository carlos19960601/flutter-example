//退出全屏显示
import 'dart:developer';
import 'dart:io';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

Future<void> exitFullScreen() async {
  late SystemUiMode mode = SystemUiMode.edgeToEdge;
  if (Platform.isAndroid || Platform.isIOS) {
    if (Platform.isAndroid &&
        (await DeviceInfoPlugin().androidInfo).version.sdkInt < 29) {
      mode = SystemUiMode.manual;
    }
    await SystemChrome.setEnabledSystemUIMode(
      mode,
      overlays: SystemUiOverlay.values,
    );
    await SystemChrome.setPreferredOrientations([]);
  }
}

Future<void> enterFullScreen() async {
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

//横屏
Future<void> landScape() async {
  if (Platform.isAndroid || Platform.isIOS) {
    await AutoOrientation.landscapeAutoMode(forceSensor: true);
  }
}

//竖屏
Future<void> verticalScreen() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
