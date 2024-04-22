import 'package:cashew/pages/navigation_framework/view.dart';
import 'package:cashew/pages/onboarding/view.dart';
import 'package:cashew/core/storage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Box settings = GStorage.settings;
  @override
  Widget build(BuildContext context) {
    if (!settings.get(SettingBoxKey.hasOnboarded, defaultValue: false)) {
      return const OnBoardingPage();
    }
    return const PageNavigationFramework();
  }
}
