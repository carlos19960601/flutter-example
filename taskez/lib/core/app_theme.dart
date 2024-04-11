import 'package:flutter/material.dart';
import 'package:taskez/core/app_color.dart';

class AppTheme {
  const AppTheme._();

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

class ButtonStyles {
  static final ButtonStyle imageRounded = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(
      HexColor.fromHex("181A1F"),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(
          color: HexColor.fromHex(
            "666A7A",
          ),
          width: 1,
        ),
      ),
    ),
  );
}
