import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:v2ex/pages/home/view.dart';
import 'package:v2ex/routes/app_pages.dart';
import 'package:v2ex/utils/global.dart';

void main() async {
  await Global.init();
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (BuildContext context) => const MyApp(),
  ));
  if (Platform.isAndroid) {}
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return GetMaterialApp(
          title: "V2EX",
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          getPages: AppPages.routes,
          home: const HomePage(),
        );
      },
    );
  }
}
