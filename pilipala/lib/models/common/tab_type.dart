import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/pages/hot/controller.dart';
import 'package:pilipala/pages/hot/view.dart';
import 'package:pilipala/pages/rcmd/controller.dart';
import 'package:pilipala/pages/rcmd/view.dart';

enum TabType { live, rcmd, hot, bangumi }

List tabsConfig = [
  {
    'icon': const Icon(
      Icons.thumb_up_off_alt_outlined,
      size: 15,
    ),
    'label': '推荐',
    'type': TabType.rcmd,
    'ctr': Get.find<RcmdController>,
    'page': const RcmdPage(),
  },
  {
    'icon': const Icon(
      Icons.whatshot_outlined,
      size: 15,
    ),
    'label': '热门',
    'type': TabType.hot,
    'ctr': Get.find<HotController>,
    'page': const HotPage(),
  },
];
