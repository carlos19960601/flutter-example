import 'package:flutter/material.dart';
import 'package:parallax_effect/core/app_color.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData lightTheme = ThemeData(
    fontFamily: "SF Pro Display",
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
