import 'package:flutter/material.dart';
import 'package:get/get.dart';

TextStyle headlineStyle() {
  return Get.theme.textTheme.titleMedium ?? const TextStyle();
}

TextStyle headline1Style() {
  return Get.theme.textTheme.displayLarge ?? const TextStyle();
}

TextStyle body1Style() {
  return Get.theme.textTheme.bodyLarge ?? const TextStyle();
}

TextStyle captionStyle() {
  return Get.theme.textTheme.bodySmall ?? const TextStyle();
}
