import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/player/widgets/lyric/playing_lyric_view.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/widgets/blur_background.dart';
import 'package:flutter_cloud_music/common/widgets/comment_button.dart';
import 'package:flutter_cloud_music/common/widgets/play_album_cover.dart';
import 'package:flutter_cloud_music/common/widgets/playing_title.dart';
import 'package:flutter_cloud_music/models/song_model.dart';
import 'package:flutter_cloud_music/pages/playing/controller.dart';
import 'package:get/get.dart';
import 'package:flutter_cloud_music/common/player/player.dart';

class PlayingPage extends GetView<PlayingController> {
  const PlayingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //背景
          Obx(() => BlurBackground(
              musicCoverUrl: context.curPlayRx.value?.al.picUrl)),
          Material(
            color: Colors.transparent,
            child: Column(
              children: [
                //标题bar
                Obx(() => PlayingTitle(song: context.curPlayRx.value)),
                //唱片动画
                Obx(() => _CenterSection(music: controller.curPlaying.value)),
                //点赞等操作
                const _PlayingOperationBar(),
                //控制器
                const PlayerControllerBar(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _PlayingOperationBar extends StatelessWidget {
  const _PlayingOperationBar({super.key});

  @override
  Widget build(BuildContext context) {
    const iconColor = AppColors.color217;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Image.asset(
              ImageUtils.getImagePath('icn_download'),
              color: iconColor,
              width: 24,
            ),
            onPressed: () {},
          ),
          Obx(() => CommentButton(
                songId: context.curPlayRx.value?.id.toString() ?? '',
              )),
          IconButton(
              iconSize: 24,
              icon: Image.asset(
                ImageUtils.getImagePath('play_icn_more'),
                color: iconColor,
                width: 24,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }
}

class PlayerControllerBar extends StatelessWidget {
  const PlayerControllerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            iconSize: 40,
            onPressed: () {},
            icon: Image.asset(
              ImageUtils.getImagePath('play_btn_prev'),
              color: AppColors.color217,
              width: 40,
            )),
        IconButton(
            iconSize: 40,
            onPressed: () {},
            icon: Image.asset(
              ImageUtils.getImagePath('play_btn_next'),
              color: AppColors.color217,
              width: 40,
            )),
        IconButton(
            onPressed: () {},
            icon: Image.asset(
              ImageUtils.getImagePath('play_btn_src'),
              color: AppColors.color217,
              width: 40,
            ))
      ],
    );
  }
}

class _CenterSection extends StatefulWidget {
  const _CenterSection({
    super.key,
    this.music,
  });

  final Song? music;

  @override
  State<_CenterSection> createState() => _CenterSectionState();
}

class _CenterSectionState extends State<_CenterSection> {
  static bool _showLyric = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedCrossFade(
          firstChild: GestureDetector(
            onTap: () {
              _showLyric = !_showLyric;
              setState(() {});
            },
            child: PlayAlbumCover(music: widget.music),
          ),
          secondChild: PlayingLyricView(
            onTap: () {
              _showLyric = !_showLyric;
              setState(() {});
            },
          ),
          crossFadeState:
              _showLyric ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300)),
    );
  }
}
