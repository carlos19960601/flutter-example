import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColor {
  static AppColor? _instance;

  AppColor._();
  factory AppColor() => _instance ??= AppColor._();

  Color lightOrange = const Color(0xFFFAA33C);
  Color lightBlack = const Color(0xFF101725);
}
