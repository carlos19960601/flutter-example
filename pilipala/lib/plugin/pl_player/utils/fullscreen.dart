//退出全屏显示
import 'dart:io';

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
