import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/app.dart';
import 'package:flutter_cloud_music/common/player/player_interceptors.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player/music_player.dart';

void main() async {
  await GetStorage.init();
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (BuildContext context) => const MyApp(),
  ));
}

@pragma('vm:entry-point')
void playerBackgroundService() {
  log('start playerBackgroundService');
  WidgetsFlutterBinding.ensureInitialized();
  GetInstance().put(AuthService());
  runBackgroundService(
    // imageLoadInterceptor: PlayerInterceptors.loadImageInterceptor,
    playUriInterceptor: PlayerInterceptors.playUriInterceptor,
    playQueueInterceptor: QuietPlayQueueInterceptor(),
  );
}
