import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/core/app_storage.dart';
import 'package:paisa/localization/messages.dart';
import 'package:paisa/routes/app_pages.dart';
import 'package:paisa/routes/app_routes.dart';
import 'package:paisa/services/account_service.dart';
import 'package:paisa/services/category_service.dart';

class PaisaApp extends StatelessWidget {
  const PaisaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppStorage.setting.listenable(keys: [
        SettingBoxKey.appColorKey,
        SettingBoxKey.dynamicThemeKey,
      ]),
      builder: (BuildContext context, Box value, _) {
        final bool isDynamic =
            value.get(SettingBoxKey.dynamicThemeKey, defaultValue: false);
        final ThemeMode themeMode = ThemeMode
            .values[value.get(SettingBoxKey.themeModeKey, defaultValue: 0)];
        final int color =
            value.get(SettingBoxKey.appColorKey, defaultValue: 0xFF795548);
        final Color primaryColor = Color(color);

        return DynamicColorBuilder(
          builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            ColorScheme lightColorScheme;
            ColorScheme darkColorScheme;
            // 动态颜色适配
            if (lightDynamic != null && darkDynamic != null && isDynamic) {
              lightColorScheme = lightDynamic.harmonized();
              darkColorScheme = darkDynamic.harmonized();
            } else {
              lightColorScheme = ColorScheme.fromSeed(seedColor: primaryColor);
              darkColorScheme = ColorScheme.fromSeed(
                  seedColor: primaryColor, brightness: Brightness.dark);
            }

            return GetMaterialApp(
              translations: Messages(),
              locale: const Locale("zh", "CN"),
              fallbackLocale: const Locale("en", "US"),
              getPages: AppPages.routes,
              initialRoute: AppRoutes.home,
              theme: ThemeData(
                colorScheme: lightColorScheme,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: darkColorScheme,
                useMaterial3: true,
              ),
              initialBinding: BindingsBuilder(() {
                Get.lazyPut(() => AccountService());
                Get.lazyPut(() => CategoryService());
              }),
            );
          },
        );
      },
    );
  }
}
