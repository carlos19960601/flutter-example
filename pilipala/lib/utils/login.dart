import 'package:get/get.dart';
import 'package:pilipala/pages/dynamics/controller.dart';
import 'package:pilipala/pages/home/controller.dart';
import 'package:pilipala/pages/mine/controller.dart';

class LoginUtils {
  static Future refreshLoginStatus(bool status) async {
    // 更改主页登录状态
    HomeController homeCtr = Get.find<HomeController>();
    homeCtr.updateLoginStatus(status);

    MineController mineCtr = Get.find<MineController>();
    mineCtr.userLogin.value = status;

    DynamicsController dynamicsCtr = Get.find<DynamicsController>();
    dynamicsCtr.userLogin.value = status;
  }
}
