import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColor {
  static AppColor get inst => _instance;
  static final AppColor _instance = AppColor._internal();

  AppColor._internal();

  final _colorSchemeOfSubPages = Rxn<Color>();
}
