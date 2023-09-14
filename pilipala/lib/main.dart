import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/pages/main/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme? lightColorScheme;
        ColorScheme? darkColorScheme;

        return GetMaterialApp(
          title: "PiLiPaLa",
          home: const MainApp(),
        );
      },
    );
  }
}
