import 'package:chrono/core/app_path.dart';
import 'package:chrono/core/app_storage.dart';
import 'package:flutter/material.dart';

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeAppDataDirectory();
    await AppStorage().init();
  }
}
