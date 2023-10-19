import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/pages/account_selector/view.dart';
import 'package:paisa/pages/category_selector/view.dart';
import 'package:paisa/pages/intro/view.dart';
import 'package:paisa/pages/on_boarding/view.dart';
import 'package:paisa/utils/storage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Box setting = GStorage.setting;
  late bool userIntroShown;
  late String name;
  late String image;
  late bool userCategorySelectorDone;
  late bool accountSelectorDone;

  @override
  void initState() {
    super.initState();
    userIntroShown =
        setting.get(SettingBoxKey.userIntroShown, defaultValue: false);
    name = setting.get(SettingBoxKey.userNameKey, defaultValue: "");
    image = setting.get(SettingBoxKey.userImageKey, defaultValue: "");
    userCategorySelectorDone =
        setting.get(SettingBoxKey.userCategorySelectorKey, defaultValue: false);
    accountSelectorDone =
        setting.get(SettingBoxKey.userAccountSelectorKey, defaultValue: false);
  }

  @override
  Widget build(BuildContext context) {
    if (!userIntroShown) {
      return const IntroPage();
    }
    if (name.isEmpty || image.isEmpty) {
      return const UserOnboardingPage();
    }

    if (!userCategorySelectorDone) {
      return const CategorySelectorPage();
    }

    if (!accountSelectorDone) {
      return const AccountSelectorPage();
    }
    return const Placeholder();
  }
}
