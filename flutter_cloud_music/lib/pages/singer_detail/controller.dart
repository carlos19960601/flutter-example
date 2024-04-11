import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/widgets/undeveloped.dart';
import 'package:flutter_cloud_music/http/api.dart';
import 'package:flutter_cloud_music/http/music.dart';
import 'package:flutter_cloud_music/models/singer_detail_model.dart';
import 'package:flutter_cloud_music/pages/singer_detail/state.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widgets/album/singer_albums_view.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widgets/home/singer_home_view.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widgets/song/singer_songs_view.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widgets/video/singer_video_view.dart';
import 'package:get/get.dart';

class SingerDetailController extends GetxController
    with GetTickerProviderStateMixin {
  final state = SingerDetailState();

  @override
  void onInit() {
    super.onInit();
    state.detail.listen((detail) {
      if (state.tabController == null && detail != null) {
        initTabs(detail);
      }
    });
    _getDetail();
  }

  void _getDetail() {
    if (GetUtils.isNullOrBlank(state.accountId.value) == true) {
      //获取歌手详情
      MusicHttp.getSingerInfo(state.artistId!)
          .then((ApiResponse<SingerDetailModel?> response) {
        state.accountId.value = response.data?.user?.userId.toString();
        state.detail.value = response.data?.detail;
      });
    } else {}
  }

  void initTabs(SingerOrUserDetail detail) {
    state.tabs ??= List.empty(growable: true);
    state.tabs!
        .add(const SingerTabModel(type: SingerTabType.homePage, title: "主页"));
    if (state.isSinger()) {
      state.tabs!
          .add(const SingerTabModel(type: SingerTabType.songPage, title: '歌曲'));
      state.tabs!.add(SingerTabModel(
          type: SingerTabType.albumPage,
          title: '专辑',
          num: state.getAlbumSize() ?? 0));
    }

    if (state.isSinger()) {
      state.tabs!.add(SingerTabModel(
          type: SingerTabType.mvPage,
          title: '视频',
          num: state.getMVSize() ?? 0));
    }

    state.tabController =
        TabController(length: state.tabs!.length, vsync: this);
  }

  List<Widget> getTabBarViews() {
    final widgets = List<Widget>.empty(growable: true);
    for (final element in state.tabs!) {
      switch (element.type) {
        case SingerTabType.homePage:
          widgets.add(SingerHomeView(state: state, controller: this));
          break;
        case SingerTabType.songPage:
          widgets.add(SingerSongsView(id: state.getArtistId()!));
          break;
        case SingerTabType.albumPage:
          widgets.add(SingerAlbumsView(id: state.getArtistId()!));
          break;
        case SingerTabType.evenPage:
          widgets.add(const UnDeveloped());
          break;
        case SingerTabType.mvPage:
          widgets.add(SingerVideoView(id: state.getArtistId()!));
          break;
      }
    }
    return widgets;
  }
}
