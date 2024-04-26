import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/models/common/rank_type.dart';
import 'package:pilipala/utils/storage.dart';

class RankController extends GetxController with GetTickerProviderStateMixin {
  late RxList tabs = [].obs;
  RxInt initialIndex = 0.obs;

  late List tabsCtrList;
  late List<Widget> tabsPageList;
  late TabController tabController;

  // 显示
  late bool enableGradientBg;

  // 存储
  Box setting = GStorage.setting;

  @override
  void onInit() {
    super.onInit();
    enableGradientBg =
        setting.get(SettingBoxKey.enableGradientBg, defaultValue: true);
    // 进行tabs配置
    setTabConfig();
  }

  void setTabConfig() async {
    tabs.value = tabsConfig;
    initialIndex.value = 0;
    tabsCtrList = tabs.map((e) => e['ctr']).toList();
    tabsPageList = tabs.map<Widget>((e) => e['page']).toList();

    tabController = TabController(
      initialIndex: initialIndex.value,
      length: tabs.length,
      vsync: this,
    );
  }
}
