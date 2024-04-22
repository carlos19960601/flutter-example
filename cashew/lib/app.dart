import 'package:cashew/localization/messages.dart';
import 'package:cashew/pages/main/view.dart';
import 'package:cashew/pages/navigation_framework/view.dart';
import 'package:cashew/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

GlobalKey<PageNavigationFrameworkState> pageNavigationFrameworkKey =
    GlobalKey();

class CashewApp extends StatelessWidget {
  const CashewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Cashew",
      getPages: Routes.getPages,
      locale: const Locale("zh", "CN"),
      fallbackLocale: const Locale("en", "US"),
      translations: Messages(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }

  ColorScheme getColorScheme(Brightness brightness) {
    return ColorScheme.fromSeed(
        seedColor: const Color(0xFF1B447A), brightness: Brightness.light);
  }
}
