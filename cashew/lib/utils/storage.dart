import 'package:hive_flutter/hive_flutter.dart';

class GStorage {
  static late final Box setting;

  static Future<void> init() async {
    await Hive.initFlutter('hive');
    // 设置
    setting = await Hive.openBox('setting');
  }

  static regAdapter() {
    // Hive.registerAdapter(RecVideoItemAppModelAdapter());
  }
}

class SettingBoxKey {
  static const String accentColor = 'accentColor';
}
