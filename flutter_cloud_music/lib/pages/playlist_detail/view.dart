import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/widgets/bottom_player_widget.dart';
import 'package:flutter_cloud_music/common/widgets/sliver_fab.dart';
import 'package:flutter_cloud_music/delegates/general_sliver_delegate.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/controller.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/delegate/playlist_header_delegate.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widgets/list_content.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widgets/play_all.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widgets/top_appbar.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widgets/video_list.dart';
import 'package:get/get.dart';

class PlaylistDetailPage extends StatelessWidget {
  PlaylistDetailPage({super.key});

  double appbarHeight = 0.0;
  int timeMill = DateTime.now().millisecondsSinceEpoch;
  late PlaylistDetailController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(PlaylistDetailController(), tag: timeMill.toString());
    appbarHeight = context.mediaQuery.padding.top + 44;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Get.theme.cardColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44),
        child: PlaylistTopAppbar(
          appBarHeight: appbarHeight,
          controller: controller,
        ),
      ),
      body: BottomPlayerController(child: _buildContent(context)),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SliverFab(
      slivers: [
        //头部内容 背景和简介等
        SliverPersistentHeader(
          pinned: true,
          delegate: PlaylistSliverHeaderDelegate(
            controller: controller,
            expendHeight: controller.expandedHeight,
            minHeight: appbarHeight,
          ),
        ),
        // 间距
        SliverPersistentHeader(
          delegate: GeneralSliverDelegate(
            child: const PreferredSize(
              preferredSize: Size.fromHeight(32),
              child: SizedBox.shrink(),
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: GeneralSliverDelegate(
            child: PlDetailPlayAll(
              controller: controller,
            ),
          ),
        ),
        //列表
        Obx(
          () => controller.detail.value?.playlist.specialType == 200
              ? VideoListContent(
                  videos: controller.detail.value!.playlist.videos,
                  controller: controller,
                )
              : PlayListContent(
                  songs: controller.songs.toList(),
                  controller: controller,
                ),
        ),
        SliverToBoxAdapter(
          child: paddingBottomBox(),
        ),
      ],
    );
  }
}
