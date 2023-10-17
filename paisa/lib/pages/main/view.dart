import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/pages/intro/view.dart';
import 'package:paisa/utils/storage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Box setting = GStorage.setting;
  late bool userIntroShown;

  @override
  void initState() {
    super.initState();
    userIntroShown =
        setting.get(SettingBoxKey.userIntroShown, defaultValue: false);
  }

  @override
  Widget build(BuildContext context) {
    if (!userIntroShown) {
      return IntroPage();
    }
    return const Placeholder();
  }
}
