import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/models/mine_playlist.dart';
import 'package:flutter_cloud_music/pages/mine/controller.dart';
import 'package:flutter_cloud_music/pages/mine/widgets/bar.dart';
import 'package:flutter_cloud_music/pages/mine/widgets/pl_cell.dart';
import 'package:flutter_cloud_music/pages/mine/widgets/user_card.dart';
import 'package:get/get.dart';

class MinePage extends StatelessWidget {
  MinePage({super.key});
  final MineController controller = Get.put(MineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          MineViewBar(),
          SliverToBoxAdapter(
            child: MineUserCard(),
          ),
          Obx(
            () => _buildMineLikePl(
              context,
              controller.minePlaylist.value?.getIntelligent(),
            ),
          ),
        ],
      ),
    );
  }

  ///我喜欢的音乐歌单
  Widget _buildMineLikePl(BuildContext context, MinePlaylist? likePl) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: _buildCardBg(context, radius: 12),
        child: MinePlaylistCell(playlist: likePl),
      ),
    );
  }

  Decoration _buildCardBg(BuildContext context, {double radius = 16}) {
    return BoxDecoration(
      color: context.theme.cardColor,
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
    );
  }
}
