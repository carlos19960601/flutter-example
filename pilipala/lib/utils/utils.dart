import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';
import 'package:pilipala/http/init.dart';

class Utils {
  static Future<String> getCookiePath() async {
    Directory tempDir = await getApplicationSupportDirectory();
    String tempPath = "${tempDir.path}/.plpl/";
    Directory dir = Directory(tempPath);

    bool b = await dir.exists();
    if (!b) {
      dir.createSync(recursive: true);
    }

    return tempPath;
  }

  static Future<bool> checkUpdate() async {
    // var result = await Request().get(Api.latestApp);
    Request();

    return false;
  }

  static String timeFormat(dynamic time) {
    if (time is String && time.contains(":")) {
      return time;
    }

    if (time < 3600) {
      int minute = time ~/ 60;
      double res = time / 60;
      if (minute != res) {
        return '${minute < 10 ? '0$minute' : minute}:${(time - minute * 60) < 10 ? '0${(time - minute * 60)}' : (time - minute * 60)}';
      } else {
        return '$minute:00';
      }
    } else {
      int hour = time ~/ 3600;
      String hourStr = hour < 10 ? '0$hour' : hour.toString();
      var a = timeFormat(time - hour * 3600);
      return '$hourStr:$a';
    }
  }

  static String makeHeroTag(v) {
    return v.toString() + Random().nextInt(9999).toString();
  }
}
