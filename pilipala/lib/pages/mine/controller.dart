import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/http/user.dart';
import 'package:pilipala/models/common/theme_type.dart';
import 'package:pilipala/models/user/info.dart';
import 'package:pilipala/models/user/stat.dart';
import 'package:pilipala/utils/storage.dart';

class MineController extends GetxController {
  // 用户信息 头像、昵称、lv
  Rx<UserInfoData> userInfo = UserInfoData().obs;
  // 用户状态 动态、关注、粉丝
  Rx<UserStat> userStat = UserStat().obs;

  Rx<ThemeType> themeType = ThemeType.system.obs;
  RxBool userLogin = false.obs;

  Box userInfoCache = GStorage.userInfo;

  @override
  onInit() {
    super.onInit();
    if (userInfoCache.get("userInfoCache") != null) {
      userInfo.value = userInfoCache.get('userInfoCache');
      userLogin.value = true;
    }

    themeType.value = ThemeType.values[ThemeType.system.code];
  }

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
    } else {
      int mid = userInfo.value.mid!;
      String face = userInfo.value.face!;
      Get.toNamed(
        '/member?mid=$mid',
        arguments: {'face': face},
      );
    }
  }

  Future queryUserInfo() async {
    if (!userLogin.value) {
      return {'status': false};
    }
    var res = await UserHttp.userInfo();
    if (res["status"]) {
      if (res['data'].isLogin) {
        userInfo.value = res["data"];
        userInfoCache.put("userInfoCache", res["data"]);
        userLogin.value = true;
      } else {
        resetUserInfo();
      }
    } else {
      resetUserInfo();
    }

    await queryUserStatOwner();
    return res;
  }

  queryUserStatOwner() async {
    var res = await UserHttp.userStatOwner();
    if (res['status']) {
      userStat.value = res['data'];
    }
    return res;
  }

  resetUserInfo() async {
    userInfo.value = UserInfoData();
    userStat.value = UserStat();
    userInfoCache.delete('userInfoCache');
    userLogin.value = false;
  }
}
