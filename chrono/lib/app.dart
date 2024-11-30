import 'package:chrono/core/app_storage.dart';
import 'package:chrono/routes/app_pages.dart';
import 'package:chrono/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 92, 182, 123));
    return GetMaterialApp(
      title: "Chrono",
      theme: ThemeData(
        colorScheme: colorScheme,
      ),
      initialRoute: AppStorage().isFresh ? Routes.onboarding : Routes.main,
      getPages: AppPages.routes,
    );
  }
}
