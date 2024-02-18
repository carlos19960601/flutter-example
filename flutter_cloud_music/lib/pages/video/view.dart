import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widgets/video/state.dart';
import 'package:flutter_cloud_music/pages/video/controller.dart';
import 'package:flutter_cloud_music/pages/video/controller/video_list_controller.dart';
import 'package:flutter_cloud_music/pages/video/state.dart';
import 'package:flutter_cloud_music/pages/video/widgets/video_content.dart';
import 'package:flutter_cloud_music/pages/video/widgets/video_right_buttons.dart';
import 'package:flutter_cloud_music/pages/video/widgets/video_scaffold.dart';
import 'package:flutter_cloud_music/pages/video/widgets/video_user_info.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();

  ///固定的列表，不需要无限加载
  static void startWithList(List<VideoModel> list, {int index = 0}) {
    Get.toNamed(Routes.VIDEO_PLAY, arguments: {
      'type': VideoState.TYPE_LIST,
      'data': list,
      'index': index
    });
  }
}

class _VideoPageState extends State<VideoPage> {
  final VideoController controller = Get.find<VideoController>();
  final VideoState state = Get.find<VideoController>().videoState;

  @override
  Widget build(BuildContext context) {
    return VideoScaffold(
      header: _buildHeader(),
      page: PageView.builder(
        controller: state.pageController,
        itemCount: state.videoListController.videoCount,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final player = state.videoListController.playerOfIndex(index);
          final rightButtons = VideoRightButtons(
            controller: player,
          );
          final content = player?.controllerValue == null
              ? Center(
                  child: _buildCover(player),
                )
              : Center(
                  child: AspectRatio(
                    aspectRatio: player!.controllerValue!.value.aspectRatio,
                    child: VideoPlayer(player.controllerValue!),
                  ),
                );
          final userInfo = VideoUserInfoWidget(controller: player!);
          return VideoContent(
            videoController: player,
            video: content,
            rightButtonColumn: rightButtons,
            userInfoWidget: userInfo,
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Image.asset(
              ImageUtils.getImagePath('dij'),
              color: Colors.white,
              width: 25,
              height: 25,
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              ImageUtils.getImagePath("cb"),
              color: Colors.white,
              width: 25,
              height: 25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCover(VPVideoController? player) {
    return CachedNetworkImage(
      imageUrl: player?.videoModel.coverUrl ??
          player?.videoModel.resource?.mlogBaseData.coverUrl ??
          "",
      width: Get.mediaQuery.size.width,
      fit: BoxFit.fitWidth,
    );
  }
}
