import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paisa/app.dart';
import 'package:paisa/core/app_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStorage.init();
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const PaisaApp(),
  ));
}
