import 'package:apidash/consts.dart';
import 'package:apidash/pages/dashboard/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashApp extends StatefulWidget {
  const DashApp({super.key});

  @override
  State<DashApp> createState() => _DashAppState();
}

class _DashAppState extends State<DashApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: kFontFamily,
        colorSchemeSeed: kColorSchemeSeed,
        brightness: Brightness.light,
      ),
      themeMode: ThemeMode.light,
      home: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const Dashboard();
  }
}
