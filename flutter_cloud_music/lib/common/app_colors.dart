import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  AppColors._();

  static const Color appMain = Color.fromARGB(255, 201, 61, 45);
  static const Color appMainLight = Color.fromARGB(255, 235, 77, 68);

  static const Color body1TxtColor = Color.fromARGB(255, 49, 49, 50);
  static Color darkBody1TxtColor = Colors.white.withOpacity(0.85);

  static const Color body2TxtColor = Color.fromARGB(255, 51, 51, 53);
  static Color darkBody2TxtColor = Colors.white.withOpacity(0.85);

  static const Color textGray = Color.fromARGB(255, 191, 190, 191);

  static const Color cardColor = Color.fromARGB(255, 255, 255, 255);

  static const Color bgColor = Color.fromARGB(255, 246, 245, 246);

  static const Color headline1Color = Color.fromARGB(255, 40, 40, 42);
  static const Color darkHeadline1Color = Color.fromARGB(255, 254, 254, 254);

  static const Color headline4Color = Color.fromARGB(255, 39, 38, 40);
  static const Color darkHeadline4Color = Color.fromARGB(255, 254, 254, 254);

  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteDark = Color(0xFFF0F0F0);

  static const Color shadowColor = Color.fromRGBO(235, 237, 242, 0.5);
  static const Color shadowColorDark = Color(0x61000000);

  static const Color btnSelectedColor = Color.fromARGB(255, 225, 53, 52);
  static const Color btnSelectedColorDark = Color.fromARGB(255, 97, 26, 26);

  /// 深色背景
  static const Color back1 = Color(0xff1D1F22);

  /// 比深色背景略深一点
  static const Color back2 = Color(0xff121314);

  static const Color color109 = Color.fromARGB(255, 109, 109, 109);
  static const Color color150 = Color.fromARGB(255, 150, 150, 150);
  static const Color color156 = Color.fromARGB(255, 156, 156, 156);
  static const Color color163 = Color.fromARGB(255, 163, 163, 163);
  static const Color color187 = Color.fromARGB(255, 187, 187, 187);
  static const Color color217 = Color.fromARGB(255, 217, 217, 217);
  static const Color color245 = Color.fromARGB(255, 245, 245, 245);

  static Color loadImagePlaceholder() =>
      Get.isDarkMode ? white.withOpacity(0.1) : color245;
}
