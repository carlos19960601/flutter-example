import 'package:hive_flutter/hive_flutter.dart';

class AppStorage {
  static AppStorage? _instance;

  AppStorage._();

  factory AppStorage() => _instance ??= AppStorage._();

  late final Box setting;

  init() async {
    await Hive.initFlutter("hive");
    regAdapter();
    setting = await Hive.openBox('setting');
  }

  static regAdapter() {
    // Hive
    //   ..registerAdapter(CategoryModelAdapter())
    //   ..registerAdapter(AccountModelAdapter())
    //   ..registerAdapter(CardTypeAdapter());
  }
}

class SettingBoxKey {
  // 介绍页
  static const String userIntroShown = 'user_intro_shown';
  static const String userNameKey = 'user_name_key';
  static const String userImageKey = 'user_image_key';
  static String userCategorySelectorKey = 'user_category_selector_key';
  static const String userAccountSelectorKey = 'user_account_selector_key';

  // 设置
  static const String themeModeKey = "theme_mode_key";
  static const String primaryColorKey = "primary_color_key";
  static const String appFontFamilyKey = "app_font_family_key";
}
