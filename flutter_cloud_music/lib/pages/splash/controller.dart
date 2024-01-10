import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final bool isFirst = box.read("isFirst") ?? true;

  @override
  void onReady() async {
    await Future.delayed(Duration(milliseconds: isFirst ? 6000 : 2000));
    toHome();
  }

  void toHome() {
    box.write('isFirst', false);
    Get.offAllNamed(Routes.HOME);
  }
}
