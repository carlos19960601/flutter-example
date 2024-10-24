import 'package:chrono/models/clock/time.dart';
import 'package:chrono/models/common/tag.dart';
import 'package:get_storage/get_storage.dart';

class AppStorage {
  static final AppStorage _instance = AppStorage._internal();
  AppStorage._internal();
  factory AppStorage() => _instance;

  late final GetStorage localCache;
  late final GetStorage setting;
  late final GetStorage userInfo;
  late final GetStorage video;

  Future<void> init() async {
    await GetStorage.init("localCache");
    await GetStorage.init("setting");

    localCache = GetStorage("localCache");
    setting = GetStorage("setting");
  }

  String? get accessToken => localCache.read(LocalCacheKey.accessToken);
  setAccessToken(String token) {
    localCache.write(LocalCacheKey.accessToken, token);
  }

  bool get isFresh => localCache.read<bool>(LocalCacheKey.isFresh) ?? true;
  setIsFresh(bool isFresh) {
    localCache.write(LocalCacheKey.isFresh, isFresh);
  }

  TimeFormat get timeFormat => TimeFormat
      .values[setting.read(SettingBoxKey.timeFormat) ?? TimeFormat.h12.code];
  setTimeFormat(TimeFormat timeFormat) {
    setting.write(SettingBoxKey.timeFormat, timeFormat.code);
  }

  List<Tag> get tags => setting.read<List<Tag>>(SettingBoxKey.tags) ?? [];
  setTags(List<Tag> tags) {
    setting.write(SettingBoxKey.tags, tags);
  }
}

class LocalCacheKey {
  static const String accessToken = "accessToken", isFresh = "isFresh";
}

class SettingBoxKey {
  static const String timeFormat = "timeFormat",
      tags = "tags",

      /// 外观
      themeMode = 'themeMode',
      enableGradientBg = 'enableGradientBg';
}
