import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/models/common/tab_type.dart';
import 'package:pilipala/utils/storage.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late RxList tabs = [].obs;
  RxInt initialIndex = 1.obs;
  late TabController tabController;
  late List tabCtrList;
  late List<Widget> tabsPageList;
  Box userInfoCache = GStorage.userInfo;
  Box setting = GStorage.setting;
  late final StreamController<bool> searchBarStream =
      StreamController.broadcast();
  late bool hideSearchBar;
  late RxString defaultSearch = "".obs;
  late bool enableGradientBg;
  var userInfo;
  RxBool userLogin = false.obs;
  RxString userFace = "".obs;
  late List defaultTabs;

  @override
  void onInit() {
    super.onInit();
    userInfo = userInfoCache.get("userInfoCache");
    userLogin.value = userInfo != null;
    userFace.value = userInfo != null ? userInfo.face : "";
    hideSearchBar =
        setting.get(SettingBoxKey.hideSearchBar, defaultValue: true);
    if (setting.get(SettingBoxKey.enableSearchWord, defaultValue: true)) {}
    enableGradientBg =
        setting.get(SettingBoxKey.enableGradientBg, defaultValue: true);

    setTabConfig();
  }

  void animateToTop() {
    int index = tabController.index;
    var ctr = tabCtrList[index];
    ctr().animateToTop();
  }

  void setTabConfig() {
    defaultTabs = [...tabsConfig];

    tabs.value = defaultTabs;

    tabCtrList = tabs.map((element) => element["ctrl"]).toList();
    tabsPageList = tabs.map<Widget>((element) => element["page"]).toList();

    tabController = TabController(
        initialIndex: initialIndex.value, length: tabs.length, vsync: this);
  }

  void updateLoginStatus(val) async {
    userInfo = await userInfoCache.get('userInfoCache');
    userLogin.value = val ?? false;
    if (val) return;
    userFace.value = userInfo != null ? userInfo.face : "";
  }
}
