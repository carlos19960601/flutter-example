import 'package:flutter/material.dart';

class AppColor {
  const AppColor._();

  static const Color primarySwatch1 = Color.fromRGBO(254, 115, 1, 1);

  static const Color tabBarDefaultForeColor = Color.fromRGBO(142, 142, 142, 1);
  static const Color mainBackgroundColor = Color.fromRGBO(241, 242, 241, 1);

  static const String primaryValueString = "#24292E";
  static const String primaryLightValueString = "#42464b";
  static const String primaryDarkValueString = "#121917";
  static const String miWhiteString = "#ececec";
  static const String actionBlueString = "#267aff";
  static const String webDraculaBackgroundColorString = "#282a36";

//  static const int primaryValue = 0xFF24292E;
//  static const int primaryLightValue = 0xFF42464b;
//  static const int primaryDarkValue = 0xFF121917;
  static const int primaryValue = 0xFFfe7301;
  static const int primaryLightValue = 0xFFfe7301;
  static const int primaryDarkValue = 0xFFfe7301;

  static const int cardWhite = 0xFFFFFFFF;
  static const int textWhite = 0xFFFFFFFF;
  static const int miWhite = 0xffececec;
  static const int white = 0xFFFFFFFF;
  static const int actionBlue = 0xff267aff;
  static const int subTextColor = 0xff959595;
  static const int subLightTextColor = 0xffc4c4c4;

//  static const int mainBackgroundColor = miWhite;

  static const int mainTextColor = primaryDarkValue;
  static const int textColorWhite = white;

  static const MaterialColor primarySwatch = MaterialColor(
    primaryValue,
    <int, Color>{
      50: Color(primaryLightValue),
      100: Color(primaryLightValue),
      200: Color(primaryLightValue),
      300: Color(primaryLightValue),
      400: Color(primaryLightValue),
      500: Color(primaryValue),
      600: Color(primaryDarkValue),
      700: Color(primaryDarkValue),
      800: Color(primaryDarkValue),
      900: Color(primaryDarkValue),
    },
  );

  static const Color themeColor = Color.fromRGBO(132, 95, 63, 1.0);
  static const Color floorTitleColor = Color.fromRGBO(51, 51, 51, 1);
  static const Color searchBarBgColor = Color.fromRGBO(240, 240, 240, 1.0);
  static const Color searchBarTxtColor = Color(0xFFCDCDCD);
  static const Color divideLineColor = Color.fromRGBO(245, 245, 245, 1.0);
  static const Color categoryDefaultColor = Color(0xFF666666);
  static const Color priceColor = Color.fromRGBO(182, 9, 9, 1.0);
  static const Color pinweicorverSubtitleColor =
      Color.fromRGBO(153, 153, 153, 1.0);
  static const Color pinweicorverBtbgColor = themeColor;
  static const Color pinweicorverBtTxtColor = Color(0xFFFFFFFF);
  static const Color tabtxtColor = Color.fromRGBO(88, 88, 88, 1.0);
  static const Color cartDisableColor = Color.fromRGBO(221, 221, 221, 1.0);
  static const Color cartItemChangenumBtColor =
      Color.fromRGBO(153, 153, 153, 1.0);
  static const Color cartItemCountTxtColor = Color.fromRGBO(102, 102, 102, 1.0);
  static const Color cartBottomBgColor = Color(0xFFFFFFFF);
  static const Color goPayBtBgColor = themeColor;
  static const Color goPayBtTxtColor = Color(0xFFFFFFFF);
  static const Color searchAppBarBgColor = Color(0xFFFFFFFF);

  static const Color bottomBarbgColor = Color.fromRGBO(250, 250, 250, 1.0);

  static const Color searchRecomendDividerColor = Color(0xFFdedede);
}
