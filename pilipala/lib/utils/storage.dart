import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pilipala/models/home/rcmd/result.dart';
import 'package:pilipala/models/user/info.dart';

class GStorage {
  static late final Box userInfo;
  static late final Box recVideo;
  static late final Box localCache;

  static Future<void> init() async {
    final dir = await getApplicationSupportDirectory();
    final path = dir.path;
    await Hive.initFlutter('$path/hive');
    regAdapter();
    // 首页推荐视频
    recVideo = await Hive.openBox(
      'recVideo',
      compactionStrategy: (entries, deletedEntries) {
        return deletedEntries > 12;
      },
    );
    userInfo = await Hive.openBox("userInfo",
        compactionStrategy: (entries, deletedEntries) {
      return deletedEntries > 2;
    });
    localCache = await Hive.openBox(
      "localCache",
      compactionStrategy: (entries, deletedEntries) {
        return deletedEntries > 4;
      },
    );
  }

  static regAdapter() {
    Hive.registerAdapter(RecVideoItemAppModelAdapter());
    Hive.registerAdapter(UserInfoDataAdapter());
    Hive.registerAdapter(LevelInfoAdapter());
    Hive.registerAdapter(RcmdStatAdapter());
    Hive.registerAdapter(RcmdReasonAdapter());
    Hive.registerAdapter(RcmdOwnerAdapter());
  }
}

class LocalCacheKey {
  // 历史记录暂停状态 默认false 记录
  static const String historyPause = 'historyPause';
  // access_key
  static const String accessKey = "accessKey";

  static const String wbiKeys = 'wbiKeys';
  static const String timeStamp = 'timeStamp';

  // 弹幕相关设置 屏蔽类型 显示区域 透明度 字体大小 弹幕速度
  static const String danmakuBlockType = 'danmakuBlockType';
  static const String danmakuShowArea = 'danmakuShowArea';
  static const String danmakuOpacity = 'danmakuOpacity';
  static const String danmakuFontScale = 'danmakuFontScale';
  static const String danmakuSpeed = 'danmakuSpeed';
}

class VideoBoxKey {
  // 视频比例
  static const String videoFit = 'videoFit';
  // 亮度
  static const String videoBrightness = 'videoBrightness';
  // 倍速
  static const String videoSpeed = 'videoSpeed';
}
