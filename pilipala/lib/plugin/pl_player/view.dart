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
  late bool enableBackgroundPlay;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    videoController = widget.controller.videoController!;
    enableBackgroundPlay = false;
  }

  @override
  Widget build(BuildContext context) {
    final _ = widget.controller;
    Color colorTheme = Theme.of(context).colorScheme.primary;
    TextStyle subTitleStyle = const TextStyle(
      height: 1.5,
      fontSize: 40.0,
      letterSpacing: 0.0,
      wordSpacing: 0.0,
      color: Color(0xffffffff),
      fontWeight: FontWeight.normal,
      backgroundColor: Color(0xaa000000),
    );

    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 12,
    );
    return Stack(
      children: [
        Obx(
          () => Video(
            controller: videoController,
            controls: NoVideoControls,
            pauseUponEnteringBackgroundMode: !enableBackgroundPlay,
            subtitleViewConfiguration: SubtitleViewConfiguration(
              style: subTitleStyle,
              textAlign: TextAlign.center,
              padding: const EdgeInsets.all(24.0),
            ),
            fit: _.videoFit.value,
          ),
        ),
      ],
    );
  }
}

class PLVideoPlayerController extends GetxController {}
