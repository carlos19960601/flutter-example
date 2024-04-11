import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa/localization/messages.dart';
import 'package:paisa/pages/main/view.dart';
import 'package:paisa/router/routes.dart';

class PaisaApp extends StatelessWidget {
  const PaisaApp({super.key});

  @override
  Widget build(BuildContext context) {
    const int color = 0xFF795548;
    const Color primaryColor = Color(color);

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme =
            ColorScheme.fromSeed(seedColor: primaryColor);
        ColorScheme darkColorScheme = ColorScheme.fromSeed(
            seedColor: primaryColor, brightness: Brightness.dark);

        return GetMaterialApp(
          translations: Messages(),
          locale: const Locale("zh", "CN"),
          fallbackLocale: const Locale("en", "US"),
          getPages: Routes.getPages,
          home: const MainPage(),
          theme: ThemeData(
            colorScheme: lightColorScheme,
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
