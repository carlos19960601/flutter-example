import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/model/account.dart';
import 'package:paisa/model/category.dart';

class GStorage {
  static late final Box setting;
  static late final Box categories;
  static late final Box accounts;

  static init() async {
    await Hive.initFlutter("hive");
    regAdapter();
    setting = await Hive.openBox('setting');
    categories = await Hive.openBox<CategoryModel>("categories");
    accounts = await Hive.openBox<AccountModel>("accounts");
  }

  static regAdapter() {
    Hive
      ..registerAdapter(CategoryModelAdapter())
      ..registerAdapter(AccountModelAdapter());
  }
}

class SettingBoxKey {
  // 介绍页
  static const String userIntroShown = 'user_intro_shown';
  static const String userNameKey = 'user_name_key';
  static const String userImageKey = 'user_image_key';
  static String userCategorySelectorKey = 'user_category_selector_key';
  static const String userAccountSelectorKey = 'user_account_selector_key';
}
