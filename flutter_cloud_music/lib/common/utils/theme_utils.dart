import 'package:flutter/material.dart';
import 'package:get/get.dart';

TextStyle headlineStyle() {
  return Get.theme.textTheme.titleMedium ?? const TextStyle();
}

TextStyle headline1Style() {
  return Get.theme.textTheme.displayLarge ?? const TextStyle();
}

TextStyle headline2Style() {
  return Get.theme.textTheme.displayMedium ?? const TextStyle();
}

TextStyle body1Style() {
  return Get.theme.textTheme.bodyLarge ?? const TextStyle();
}

TextStyle body2Style() {
  return Get.theme.textTheme.bodyMedium ?? const TextStyle();
}

TextStyle captionStyle() {
  return Get.theme.textTheme.bodySmall ?? const TextStyle();
}
