import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

  @override
  void initState() {
    super.initState();
    userIntroShown =
        setting.get(SettingBoxKey.userIntroShown, defaultValue: false);
    name = setting.get(SettingBoxKey.userNameKey, defaultValue: "");
  }

  @override
  Widget build(BuildContext context) {
    if (!userIntroShown) {
      return const IntroPage();
    }
    if (name.isEmpty) {
      return const UserOnboardingPage();
    }
    return const Placeholder();
  }
}
