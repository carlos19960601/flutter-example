import 'package:get/get.dart';
import 'package:parallax_travel_cards_hero/localization/en.dart';
import 'package:parallax_travel_cards_hero/localization/zh.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": En().messages,
        "zh_CN": Zh().messages,
      };
}
