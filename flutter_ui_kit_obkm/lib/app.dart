import 'package:flutter/material.dart';
import 'package:flutter_ui_kit_obkm/pages/main/view.dart';
import 'package:flutter_ui_kit_obkm/router/routes.dart';
import 'package:get/route_manager.dart';

class ObkmApp extends StatelessWidget {
  const ObkmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "UI Kit",
      getPages: Routes.getPages,
      themeMode: ThemeMode.light,
      home: const MainPage(),
    );
  }
}
