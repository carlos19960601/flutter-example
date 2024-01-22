import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:get/get.dart';

class RouteUtils {
  static Future<void> routeFromActionStr(String? action, {dynamic data}) async {
    Get.log(action.toString());
    if (action == null) return;

    if (action.startsWith(Routes.ROUTES_HOST)) {
      //应用内跳转
      final path = action.substring(Routes.ROUTES_HOST.length, action.length);
      Get.log(path);
      Get.toNamed('/$path');
    }
  }
}
