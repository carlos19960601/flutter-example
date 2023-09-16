import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pilipala/models/user/info.dart';

class GStorage {
  static late final Box userInfo;

  static Future<void> init() async {
    final dir = await getApplicationSupportDirectory();
    final path = dir.path;
    await Hive.initFlutter('$path/hive');
    regAdapter();
    userInfo = await Hive.openBox("userInfo",
        compactionStrategy: (entries, deletedEntries) {
      return deletedEntries > 2;
    });
  }

  static regAdapter() {
    Hive.registerAdapter(UserInfoDataAdapter());
  }
}
