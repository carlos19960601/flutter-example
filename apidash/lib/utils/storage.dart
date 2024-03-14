import 'package:apidash/models/codegen_language.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GStorage {
  static late final Box settings;
  static late final Box data;

  static Future<void> init() async {
    await Hive.initFlutter('hive');
    regAdapter();

    // 设置
    settings = await Hive.openBox('settings');
    data = await Hive.openBox('data');
  }

  static regAdapter() {
    Hive.registerAdapter(CodegenLanguageAdapter());
  }
}

class SettingBoxKey {
  static const String accentColor = 'accentColor';
  static const String hasOnboarded = "hasOnboarded";
  static const String isDark = "isDark";
  static const String alwaysShowCollectionPaneScrollbar =
      "alwaysShowCollectionPaneScrollbar";
  static const defaultUriScheme = "defaultUriScheme";
  static const saveResponses = "saveResponses";
  static const defaultCodeGenLang = "defaultCodeGenLang";
  static const promptBeforeClosing = "promptBeforeClosing";
}

class DataBoxKey {
  static const String ids = "ids";
  static const String data = "data";
}
