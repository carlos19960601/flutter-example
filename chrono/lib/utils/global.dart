import 'package:chrono/core/app_storage.dart';
import 'package:flutter/material.dart';

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppStorage().init();
  }
}
