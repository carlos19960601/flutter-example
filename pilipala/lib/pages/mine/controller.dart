import 'package:get/get.dart';
import 'package:pilipala/models/common/theme_type.dart';

class MineController extends GetxController {
  Rx<ThemeType> themeType = ThemeType.system.obs;
  RxBool userLogin = false.obs;

  onLogin() {
    if (!userLogin.value) {
      Get.toNamed(
        "/webview",
        parameters: {
          "url": 'https://passport.bilibili.com/h5-app/passport/login',
          "type": "login",
          'pageTitle': '登录bilibili',
        },
      );
    }
  }
}
