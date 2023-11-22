import 'package:blackhole/pages/auth/view.dart';
import 'package:blackhole/pages/home/view.dart';
import 'package:blackhole/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Box setting = GStorage.setting;

  @override
  Widget build(BuildContext context) {
    dynamic userId = setting.get(SettingBoxKey.userId);
    if (userId == null) {
      return const AuthPage();
    }

    return const HomePage();
  }
}
