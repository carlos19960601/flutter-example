// ignore_for_file: must_be_immutable

import 'package:get/get.dart';
import 'package:pilipala/pages/fav/view.dart';
import 'package:pilipala/pages/hot/view.dart';
import 'package:pilipala/pages/member/view.dart';
import 'package:pilipala/pages/search/view.dart';
import 'package:pilipala/pages/searchResult/view.dart';
import 'package:pilipala/pages/setting/view.dart';
import 'package:pilipala/pages/video/detail/view.dart';
import 'package:pilipala/pages/webview/view.dart';

class Routes {
  static final List<GetPage> getPages = [
    // 热门
    CustomGetPage(name: '/hot', page: () => const HotPage()),
    CustomGetPage(
      name: "/webview",
      page: () => const WebviewPage(),
    ),

    // 视频详情
    CustomGetPage(name: '/video', page: () => const VideoDetailPage()),
    // 用户中心
    CustomGetPage(name: '/member', page: () => const MemberPage()),
    // 设置
    CustomGetPage(name: '/setting', page: () => const SettingPage()),
    CustomGetPage(name: '/fav', page: () => const FavPage()),
    // 搜索页面
    CustomGetPage(name: '/search', page: () => const SearchPage()),
    // 搜索结果
    CustomGetPage(name: '/searchResult', page: () => const SearchResultPage()),
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
