import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/route_manager.dart';
import 'package:v2ex/pages/home/view.dart';
import 'package:v2ex/routes/app_pages.dart';
import 'package:v2ex/services/translation.dart';
import 'package:v2ex/utils/global.dart';
import 'package:v2ex/widgets/custom_loading.dart';

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
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          translations: Translation(),
          locale: const Locale("zh", "CN"),
          supportedLocales: const [Locale("zh", "CN"), Locale("en", "US")],
          fallbackLocale: const Locale("zh", "CN"),
          getPages: AppPages.routes,
          home: const HomePage(),
          navigatorObservers: [
            FlutterSmartDialog.observer,
          ],
          builder: (context, child) {
            return FlutterSmartDialog(
              toastBuilder: (msg) => CustomToast(msg: msg),
              child: child,
            );
          },
        );
      },
    );
  }
}
