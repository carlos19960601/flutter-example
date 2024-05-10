import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmony_music/core/app_theme.dart';
import 'package:harmony_music/localization/messages.dart';
import 'package:harmony_music/pages/home/view.dart';
import 'package:harmony_music/services/theme_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (BuildContext context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Harmony Music',
      theme: AppTheme.lightTheme,
      locale: const Locale("zh", "CN"),
      fallbackLocale: const Locale("en", "US"),
      translations: Messages(),
      home: const HomeScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(ThemeService());
      }),
    );
  }
}
