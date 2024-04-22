import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namida/core/app_color.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData getAppTheme(
      {Color? color, bool? light, bool lighterDialog = true}) {
    light ??= Get.theme.brightness == Brightness.light;
    return ThemeData(
      brightness: light ? Brightness.light : Brightness.dark,
    );
  }

  static ThemeData lightTheme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.lightBlack,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
