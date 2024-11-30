import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension ColorHelper on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Color get outline => colorScheme.outline;
  Color get outlineVariant => colorScheme.outlineVariant;
  Color get primary => colorScheme.primary;
  Color get onPrimary => colorScheme.onPrimary;
  Color get primaryContainer => colorScheme.primaryContainer;
  Color get onPrimaryContainer => colorScheme.onPrimaryContainer;
  Color get secondary => colorScheme.secondary;
  Color get onSecondary => colorScheme.onSecondary;
  Color get inverseSurface => colorScheme.inverseSurface;
  Color get onInverseSurface => colorScheme.onInverseSurface;
  Color get secondaryContainer => colorScheme.secondaryContainer;
  Color get onSecondaryContainer => colorScheme.onSecondaryContainer;
  Color get onTertiary => colorScheme.tertiary;
  Color get tertiary => colorScheme.onTertiary;
  Color get tertiaryContainer => colorScheme.tertiaryContainer;
  Color get onTertiaryContainer => colorScheme.onTertiaryContainer;
  Color get onSurfaceVariant => colorScheme.onSurfaceVariant;
  Color get surface => colorScheme.surface;
  Color get onSurface => colorScheme.onSurface;
  Color get surfaceTint => colorScheme.surfaceTint;
  Color get onBackground => colorScheme.onSurface;
  Color get error => colorScheme.error;
  Color get shadow => colorScheme.shadow;
  Color get errorContainer => colorScheme.errorContainer;
  Color get onError => colorScheme.onError;
  Color get onErrorContainer => colorScheme.onErrorContainer;
}

extension TextStyleHelper on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  TextStyle? get titleLarge => textTheme.titleLarge;
  TextStyle? get titleMedium => textTheme.titleMedium;
  TextStyle? get titleSmall => textTheme.titleSmall;
  TextStyle? get bodySmall => textTheme.bodySmall;
  TextStyle? get bodyMedium => textTheme.bodyMedium;
  TextStyle? get bodyLarge => textTheme.bodyLarge;
  TextStyle? get labelLarge => textTheme.labelLarge;
  TextStyle? get labelMedium => textTheme.labelMedium;
  TextStyle? get labelSmall => textTheme.labelSmall;
  TextStyle? get displayLarge => textTheme.displayLarge;
  TextStyle? get displayMedium => textTheme.displayMedium;
  TextStyle? get displaySmall => textTheme.displaySmall;
  TextStyle? get headlineLarge => textTheme.headlineLarge;
  TextStyle? get headlineMedium => textTheme.headlineMedium;
  TextStyle? get headlineSmall => textTheme.headlineSmall;
}

extension MediaQueryHelper on BuildContext {
  MediaQueryData get mediaQueryData => MediaQuery.of(this);

  //
  Brightness get currentBrightness => MediaQuery.platformBrightnessOf(this);
  Orientation get orientation => MediaQuery.orientationOf(this);

  bool get alwaysUse24HourFormat => mediaQueryData.alwaysUse24HourFormat;

  // Size
  double get statusBarHeight => Get.mediaQuery.padding.top; // Get查询出来的是不变的
  double get paddingTop =>
      MediaQuery.paddingOf(this).top; // paddingTop会随着在组件的调用点而变化
  double get paddingBottom => MediaQuery.paddingOf(this).bottom;
  double get sheetHeight => height - statusBarHeight - width * 9 / 16;
}

extension ThemeHelper on BuildContext {
  ThemeData get theme => Theme.of(this);

  CardTheme get cardTheme => theme.cardTheme;
}
