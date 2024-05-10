import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/core/app_storage.dart';
import 'package:paisa/routes/app_routes.dart';

class LandingMiddleware extends GetMiddleware {
  Box setting = AppStorage.setting;

  @override
  RouteSettings? redirect(String? route) {
    final bool userIntroShown =
        setting.get(SettingBoxKey.userIntroShown, defaultValue: false);
    final String name =
        setting.get(SettingBoxKey.userNameKey, defaultValue: "");
    final String image =
        setting.get(SettingBoxKey.userImageKey, defaultValue: "");
    final bool userCategorySelectorDone =
        setting.get(SettingBoxKey.userCategorySelectorKey, defaultValue: false);
    final bool accountSelectorDone =
        setting.get(SettingBoxKey.userAccountSelectorKey, defaultValue: false);

    if (!userIntroShown) {
      return const RouteSettings(name: AppRoutes.intro);
    }

    if (name.isEmpty || image.isEmpty) {
      return const RouteSettings(name: AppRoutes.onboarding);
    }

    if (!userCategorySelectorDone) {
      return const RouteSettings(name: AppRoutes.onboarding);
    }

    if (!accountSelectorDone) {
      return const RouteSettings(name: AppRoutes.onboarding);
    }

    return null;
  }
}
