// ignore_for_file: must_be_immutable

import 'package:get/get.dart';
import 'package:pilipala/pages/hot/view.dart';
import 'package:pilipala/pages/member/view.dart';
import 'package:pilipala/pages/setting/view.dart';
import 'package:pilipala/pages/webview/view.dart';

class Routes {
  static final List<GetPage> getPages = [
    // 热门
    CustomGetPage(name: '/hot', page: () => const HotPage()),
    CustomGetPage(
      name: "/webview",
      page: () => const WebviewPage(),
    ),
    // 用户中心
    CustomGetPage(name: '/member', page: () => const MemberPage()),
    // 设置
    CustomGetPage(name: '/setting', page: () => const SettingPage()),
  ];
}

class CustomGetPage extends GetPage {
  bool? fullscreen = false;

  CustomGetPage({
    name,
    page,
    this.fullscreen,
    transitionDuration,
  }) : super(
            name: name,
            page: page,
            fullscreenDialog: fullscreen != null && fullscreen);
}
