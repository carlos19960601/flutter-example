import 'package:hive_flutter/hive_flutter.dart';

class GStorage {
  static late final Box settings;
  static late final Box data;

  static Future<void> init() async {
    await Hive.initFlutter('hive');
    // 设置
    settings = await Hive.openBox('settings');
    data = await Hive.openBox('data');
  }

  static regAdapter() {
    // Hive.registerAdapter(RecVideoItemAppModelAdapter());
  }
}

class SettingBoxKey {
  static const String accentColor = 'accentColor';
  static const String hasOnboarded = "hasOnboarded";
}

class DataBoxKey {
  static const String ids = "ids";
}
