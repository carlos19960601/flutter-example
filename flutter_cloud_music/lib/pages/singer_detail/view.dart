import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/widgets/bottom_player_widget.dart';
import 'package:flutter_cloud_music/common/widgets/music_loading.dart';
import 'package:flutter_cloud_music/delegates/general_sliver_delegate.dart';
import 'package:flutter_cloud_music/pages/singer_detail/controller.dart';
import 'package:flutter_cloud_music/pages/singer_detail/state.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widgets/singer_header.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widgets/singer_tabs.dart';
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
          () => state.detail.value == null ? _buildLoading() : _buildBody(),
        ),
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
              centerTitle: false,
              leading: leading,
              backgroundColor: Get.theme.cardColor,
              titleTextStyle: Get.theme.appBarTheme.titleTextStyle,
              elevation: 0.0,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  Future.delayed(const Duration(milliseconds: 19))
                      .then((value) {
                    state.isPinned.value = constraints.biggest.height <=
                        (Get.mediaQuery.padding.top + 44);
                  });
                  return FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: SingerHeader(controller: controller),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverPersistentHeader(
            delegate: GeneralSliverDelegate(
              child: PreferredSize(
                preferredSize: const Size.fromHeight(40),
                child: SingerTabs(controller: controller),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: state.tabController,
        children: controller.getTabBarViews(),
      ),
    );
  }
}
