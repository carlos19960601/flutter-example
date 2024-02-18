import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/http/video.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widgets/video/state.dart';
import 'package:flutter_cloud_music/pages/video/controller/video_list_controller.dart';
import 'package:flutter_cloud_music/pages/video/widgets/video_scaffold.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoState {
  static const String TYPE_LIST = 'type_list';
  static const String TYPE_SINGLE = 'type_single';
  static const String TYPE_OFFSET = 'type_offset';

  ///点赞集合
  final Rxn<List<String>> favoriteIds = Rxn<List<String>>();

  late String type;

  late VideoScaffoldController videoController;
  late VideoListController videoListController;
  late PageController pageController;

  VideoState() {
    videoController = VideoScaffoldController();
    videoListController =
        VideoListController(loadMoreCount: 2, preloadCount: 2);
  }
}

extension VideoControllerExt on List<VideoModel> {
  List<VPVideoController> controllers() {
    return map((e) => VPVideoController(
          videoModel: e,
          builder: () async {
            final url = await VideoHttp.getVideoPlayUrl(e.id);
            return VideoPlayerController.networkUrl(Uri.parse(url));
          },
          countInfo: () async {
            return VideoHttp.getVideoCountInfoWithType(e.id);
          },
          info: () async {
            return VideoHttp.getVideoInfo(e.id);
          },
        )).toList();
  }
}
