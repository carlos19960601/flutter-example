import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/http/video.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widgets/video/state.dart';
import 'package:flutter_cloud_music/pages/video/controller/video_list_controller.dart';
import 'package:flutter_cloud_music/pages/video/state.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  final videoState = VideoState();

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    _initArguments(arguments);
  }

  void _initArguments(dynamic arguments) {
    videoState.type = arguments['type'].toString();
    List<VideoModel> data = List.empty();
    int index = 0;
    switch (videoState.type) {
      case VideoState.TYPE_LIST:
        data = (arguments['data'] as List).cast<VideoModel>();
        index = arguments['index'] as int;
        break;
      case VideoState.TYPE_SINGLE:
        data = [arguments['data'] as VideoModel];
        break;
      case VideoState.TYPE_OFFSET:
        data = (arguments['data'] as List).cast<VideoModel>();
        index = arguments['index'] as int;
        break;
    }

    videoState.pageController = PageController(initialPage: index);
    _initVideoController(data, index);
  }

  ///初始化播放器controller
  void _initVideoController(List<VideoModel> data, int index) {
    videoState.videoListController.init(
        pageController: videoState.pageController,
        startIndex: index,
        initialList: data.controllers(),
        videoProvider: (int index, List<VPVideoController> list) async {
          switch (videoState.type) {
            case VideoState.TYPE_SINGLE:
              final lastId = list.last.videoModel.id;
              // final data = await VideoHttp.getRelatedVideo(lastId);
              return data.controllers();
            case VideoState.TYPE_OFFSET:
              break;
          }
          return List.empty();
        });
  }
}
