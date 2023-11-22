import 'package:blackhole/localization/messages.dart';
import 'package:blackhole/pages/main/view.dart';
import 'package:blackhole/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlackholeApp extends StatelessWidget {
  const BlackholeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      locale: const Locale("zh", "CN"),
      fallbackLocale: const Locale("en", "US"),
      getPages: Routes.getPages,
      home: const MainPage(),
    );
  }
}
