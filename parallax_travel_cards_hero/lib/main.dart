import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:parallax_travel_cards_hero/core/app_theme.dart';
import 'package:parallax_travel_cards_hero/localization/messages.dart';
import 'package:parallax_travel_cards_hero/pages/home/view.dart';
import 'package:parallax_travel_cards_hero/routes/app_pages.dart';

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
      title: 'Hero Travel Card',
      theme: AppTheme.lightTheme,
      locale: const Locale("zh", "CN"),
      fallbackLocale: const Locale("en", "US"),
      translations: Messages(),
      home: HomeScreen(),
      getPages: AppPages.routes,
    );
  }
}
