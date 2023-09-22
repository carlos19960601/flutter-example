import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:pilipala/plugin/pl_player/controller.dart';

class PLVideoPlayer extends StatefulWidget {
  final PlPlayerController controller;
  final PreferredSizeWidget? headerControl;
  final PreferredSizeWidget? bottomControl;
  final Widget? danmuWidget;

  const PLVideoPlayer({
    required this.controller,
    this.headerControl,
    this.bottomControl,
    this.danmuWidget,
    super.key,
  });

  @override
  State<PLVideoPlayer> createState() => _PLVideoPlayerState();
}

class _PLVideoPlayerState extends State<PLVideoPlayer>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late VideoController videoController;
  final PLVideoPlayerController _ctr = Get.put(PLVideoPlayerController());

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    videoController = widget.controller.videoController!;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Obx(() => Video(controller: videoController))],
    );
  }
}

class PLVideoPlayerController extends GetxController {}
