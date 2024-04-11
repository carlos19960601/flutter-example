import 'package:hive_flutter/hive_flutter.dart';

class GStorage {
  static late final Box localCache;
  static late final Box setting;

  static Future<void> init() async {
    await Hive.initFlutter('blackhole');
    regAdapter();
    // 本地缓存
    localCache = await Hive.openBox("localCache");
    // 设置
    setting = await Hive.openBox('setting');
  }

  static regAdapter() {
    // Hive.registerAdapter(RecVideoItemAppModelAdapter());
  }
}

class LocalCacheKey {
  static const String accessToken = "accessToken";
}

class SettingBoxKey {
  static const String name = "name";
  static const String userId = "userId";
  static const String preferredLanguage = "preferredLanguage";
  static const String region = "region";
  static const String sectionsToShow = "sectionsToShow";
}
