import 'package:cashew/localization/messages.dart';
import 'package:cashew/pages/onboarding/view.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CashewApp extends StatelessWidget {
  const CashewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Cashew",
      locale: const Locale("zh", "CN"),
      fallbackLocale: const Locale("en", "US"),
      translations: Messages(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AnimatedSwitcher(
        duration: Duration(
          milliseconds: 1200,
        ),
        child: OnBoardingPage(
          key: ValueKey("Onboarding"),
        ),
      ),
    );
  }

  ColorScheme getColorScheme(Brightness brightness) {
    return ColorScheme.fromSeed(
        seedColor: const Color(0xFF1B447A), brightness: Brightness.light);
  }
}
