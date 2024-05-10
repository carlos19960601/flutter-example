import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ThemeType { dynamic, system, light, dark }

class ThemeService extends GetxService {
  final Rx<Color?> primaryColor = Colors.deepPurple[400].obs;
  final Rxn<ThemeData> themeData = Rxn<ThemeData>();

  late Brightness systemBrightness;

  @override
  void onInit() {
    super.onInit();
    systemBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }
}
