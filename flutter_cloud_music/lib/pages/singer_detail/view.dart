import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/widgets/bottom_player_widget.dart';
import 'package:flutter_cloud_music/common/widgets/music_loading.dart';
import 'package:flutter_cloud_music/pages/singer_detail/controller.dart';
import 'package:flutter_cloud_music/pages/singer_detail/state.dart';
import 'package:get/get.dart';

class SingerDetailPage extends StatelessWidget {
  SingerDetailPage({super.key});
  late SingerDetailController controller;
  late SingerDetailState state;

  String? _accountId;
  String? _artistId;

  @override
  Widget build(BuildContext context) {
    if (_accountId == null && _artistId == null) {
      _accountId = Get.arguments['accountId']?.toString();
      _artistId = Get.arguments['artistId']?.toString();
    }

    controller = Get.put(
      SingerDetailController()
        ..state.artistId = _artistId
        ..state.accountId.value = _accountId,
      tag: (_accountId ?? _artistId).toString(),
    );
    state = controller.state;
    return Scaffold(
      backgroundColor: Get.theme.cardColor,
      body: BottomPlayerController(
        child: Obx(
            () => state.detail.value == null ? _buildLoading() : _buildBody()),
      ),
    );
  }

  Widget _buildLoading() {
    return Container(
      padding: EdgeInsets.only(
          top: Get.mediaQuery.size.height / 2 - Get.mediaQuery.padding.top),
      alignment: Alignment.center,
      child: const MusicLoading(),
    );
  }

  Widget _buildBody() {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            Obx(
              () => SliverAppBar(
                toolbarHeight: 44,
                collapsedHeight: 44,
                title: state.isPinned.value ? Text(state.getName()) : null,
                pinned: true,
              ),
            ),
          ];
        },
        body: const TabBarView(children: []));
  }
}
