import 'package:flutter/material.dart';
import 'package:lofiii/core/app_color.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData lightTheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    scaffoldBackgroundColor: AppColor.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
  );

  static final ThemeData darkTheme =
      ThemeData.dark(useMaterial3: true).copyWith(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
