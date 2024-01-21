import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MineController extends GetxController {
  final level = 0.obs;
  final barHeight = Get.mediaQuery.padding.top + 44;

  late ScrollController scrollController;
  final barBgOpacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  _onScroll() {}
}
