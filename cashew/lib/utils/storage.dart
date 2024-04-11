import 'package:hive_flutter/hive_flutter.dart';

class GStorage {
  static late final Box settings;

  static Future<void> init() async {
    await Hive.initFlutter('hive');
    // 设置
    settings = await Hive.openBox('settings');
  }

  static regAdapter() {
    // Hive.registerAdapter(RecVideoItemAppModelAdapter());
  }
}

class SettingBoxKey {
  static const String accentColor = 'accentColor';
  static const String hasOnboarded = "hasOnboarded";
}
