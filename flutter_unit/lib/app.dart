import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unit/common/strings.dart';
import 'package:flutter_unit/router/routes.dart';
import 'package:get/route_manager.dart';

class FlutterUnit extends StatelessWidget {
  const FlutterUnit({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme lightColorScheme = ColorScheme.fromSeed(
        seedColor: const Color(0xFF795548), brightness: Brightness.light);

    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      title: Strings.appName,
      getPages: Routes.getPages,
    );
  }
}
