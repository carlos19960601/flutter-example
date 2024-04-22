import 'package:fitness_app/core/app_color.dart';
import 'package:fitness_app/core/app_font.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData lightTheme = ThemeData(
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        fontFamily: AppFont.fontRoboto,
        fontWeight: FontWeight.w400,
        fontSize: 12,
        letterSpacing: 0.2,
        color: AppColor.lightText, //
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.nearlyWhite,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
