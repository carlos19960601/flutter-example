import 'package:hive_flutter/hive_flutter.dart';

class GStorage {
  static late final Box setting;

  static init() async {
    await Hive.initFlutter("hive");

    setting = await Hive.openBox('setting');
  }
}

class SettingBoxKey {
  // 介绍页
  static const String userIntroShown = 'user_intro_shown';
  static const String userNameKey = 'user_name_key';
  static const String userImageKey = 'user_image_key';
  static String userCategorySelectorKey = 'user_category_selector_key';
}
