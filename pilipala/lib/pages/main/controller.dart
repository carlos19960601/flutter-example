import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/http/common.dart';
import 'package:pilipala/models/common/dynamic_badge_mode.dart';
import 'package:pilipala/models/common/nav_nar_config.dart';
import 'package:pilipala/pages/dynamics/view.dart';
import 'package:pilipala/pages/home/view.dart';
import 'package:pilipala/pages/media/view.dart';
import 'package:pilipala/pages/rank/view.dart';
import 'package:pilipala/utils/storage.dart';
import 'package:pilipala/utils/utils.dart';

class MainController extends GetxController {
  List<Widget> pages = <Widget>[
    const HomePage(),
    const RankPage(),
    const DynamicsPage(),
    const MediaPage(),
  ];
  RxList navigationBars = defaultNavigationBars.obs;
  // 页面滑动控制bottombar的显示
  final StreamController<bool> bottomBarStream = StreamController.broadcast();
  DateTime? _lastPressedAt;
  late PageController pageController;
  int selectedIndex = 0;
  late Rx<DynamicBadgeMode> dynamicBadgeType = DynamicBadgeMode.number.obs;
  RxBool userLogin = false.obs;

  Box setting = GStorage.setting;
  Box userInfoCache = GStorage.userInfo;

  @override
  void onInit() {
    super.onInit();
    Utils.checkUpdate();

    var userInfo = userInfoCache.get("userInfoCache");
    userLogin.value = userInfo != null;
    int defaultHomePage =
        setting.get(SettingBoxKey.defaultHomePage, defaultValue: 0) as int;
    selectedIndex = defaultNavigationBars
        .indexWhere((item) => item["id"] == defaultHomePage);
    dynamicBadgeType.value = DynamicBadgeMode.values[setting.get(
        SettingBoxKey.defaultDynamicType,
        defaultValue: DynamicBadgeMode.number.code)];
    if (dynamicBadgeType.value != DynamicBadgeMode.hidden) {
      getUnreadDynamic();
    }
  }

  void getUnreadDynamic() async {
    if (!userLogin.value) {
      return;
    }

    int dynamicItemIndex =
        navigationBars.indexWhere((element) => element["label"] == "动态");
    var res = await CommonHttp.unReadDynamic();
    var data = res["data"];
    if (dynamicItemIndex != -1) {
      navigationBars[dynamicItemIndex]['count'] =
          data == null ? 0 : data.length;
    }
    // 通知更新
    navigationBars.refresh();
  }

  void clearUnread() async {
    int dynamicItemIndex =
        navigationBars.indexWhere((element) => element["label"] == "动态");
    if (dynamicItemIndex != -1) {
      navigationBars[dynamicItemIndex]['count'] = 0; // 修改 count 属性为新的值
    }
    // 通知更新
    navigationBars.refresh();
  }

  bool onBackPressed() {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt!) >
            const Duration(seconds: 2)) {
      _lastPressedAt = DateTime.now();

      return false; // 不退出应用
    }

    return true; //退出应用
  }
}
