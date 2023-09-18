import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/models/common/tab_type.dart';
import 'package:pilipala/utils/storage.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  int initialIndex = 1;
  late List tabs;
  late List<Widget> tabsPageList;
  late TabController tabController;
  Box userInfoCache = GStorage.userInfo;
  RxBool userLogin = false.obs;
  RxString userFace = "".obs;
  var userInfo;

  @override
  void onInit() {
    super.onInit();

    userInfo = userInfoCache.get("userInfoCache");
    userLogin.value = userInfo != null;
    userFace.value = userInfo != null ? userInfo.face : "";

    // 进行tabs配置
    tabs = tabsConfig;
    tabsPageList = tabsConfig.map<Widget>((e) => e["page"]).toList();

    tabController = TabController(length: tabs.length, vsync: this);
  }

  void updateLoginStatus(val) async {
    userInfo = await userInfoCache.get('userInfoCache');
    userLogin.value = val ?? false;
    if (val) return;
    userFace.value = userInfo != null ? userInfo.face : "";
  }
}
