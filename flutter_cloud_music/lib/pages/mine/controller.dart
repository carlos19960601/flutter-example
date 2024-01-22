import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/models/mine_playlist.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:get/get.dart';

class MineController extends GetxController {
  final level = 0.obs;
  final barHeight = Get.mediaQuery.padding.top + 44;

  late ScrollController scrollController;
  final barBgOpacity = 0.0.obs;

  final minePlaylist = Rxn<List<MinePlaylist>?>();

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);

    AuthService.to.isLoggedIn.listen((login) {
      if (login) _getUserInfo();
    });
  }

  @override
  onReady() {
    _getUserInfo();
  }

  void _getUserInfo() {}

  _onScroll() {
    final opacity = scrollController.offset / barHeight;
    barBgOpacity.value = opacity > 1.0
        ? 1.0
        : opacity < 0
            ? 0
            : opacity;
  }
}

extension MinePlaylistExt on List<MinePlaylist> {
  MinePlaylist getIntelligent() {
    return firstWhere((element) => element.isIntelligent());
  }

  List<MinePlaylist> getMineCreate() {
    return where((element) => element.isMineCreate()).toList();
  }

  List<MinePlaylist> getMineCollect() {
    return where((element) => !element.isMyPl()).toList();
  }
}
