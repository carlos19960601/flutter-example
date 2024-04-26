import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/utils/storage.dart';

Box setting = GStorage.setting;

void feedback() {
  final bool enable =
      setting.get(SettingBoxKey.feedBackEnable, defaultValue: false) as bool;
  if (enable) {
    HapticFeedback.lightImpact();
  }
}
