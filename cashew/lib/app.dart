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
}
