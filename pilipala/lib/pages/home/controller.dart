import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/models/common/tab_type.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late List tabs;
  late List<Widget> tabsPageList;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();

    // 进行tabs配置
    tabs = tabsConfig;
    tabsPageList = tabsConfig.map<Widget>((e) => e["page"]).toList();

    tabController = TabController(length: tabs.length, vsync: this);
  }
}
