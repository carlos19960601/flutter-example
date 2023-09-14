import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:pilipala/pages/main/controller.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final MainController _mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
