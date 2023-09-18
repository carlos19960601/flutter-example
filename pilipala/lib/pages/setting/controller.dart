import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/http/init.dart';
import 'package:pilipala/utils/login.dart';
import 'package:pilipala/utils/storage.dart';

class SettingController extends GetxController {
  Box userInfoCache = GStorage.userInfo;

  RxBool userLogin = false.obs;
  var userInfo;

  @override
  void onInit() {
    super.onInit();
    userInfo = userInfoCache.get('userInfoCache');
    userLogin.value = userInfo != null;
  }

  loginOut() async {
    SmartDialog.show(
      builder: (context) {
        return AlertDialog(
          title: const Text("提示"),
          content: const Text('确认要退出登录吗'),
          actions: [
            TextButton(
              onPressed: () => SmartDialog.dismiss(),
              child: const Text('点错了'),
            ),
            TextButton(
              onPressed: () async {
                // 清空cookie
                await Request.cookieManager.cookieJar.deleteAll();
                Request.dio.options.headers['cookie'] = '';

                await LoginUtils.refreshLoginStatus(false);

                SmartDialog.dismiss().then((value) => Get.back());
              },
              child: const Text('确认'),
            ),
          ],
        );
      },
    );
  }
}
