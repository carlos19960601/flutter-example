import 'package:get/get.dart';
import 'package:paisa/localization/en.dart';
import 'package:paisa/localization/zh.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": En().messages,
        "zh_CN": Zh().messages,
      };
}
