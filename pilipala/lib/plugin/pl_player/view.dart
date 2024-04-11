import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:pilipala/plugin/pl_player/controller.dart';
import 'package:pilipala/plugin/pl_player/widgets/app_bar_ani.dart';
import 'package:pilipala/plugin/pl_player/widgets/bottom_control.dart';

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
            resumeUponEnteringForegroundMode: true,
            subtitleViewConfiguration: SubtitleViewConfiguration(
              style: subTitleStyle,
              textAlign: TextAlign.center,
              padding: const EdgeInsets.all(24.0),
            ),
            fit: _.videoFit.value,
          ),
        ),
        // 头部、底部控制条
        SafeArea(
          top: false,
          bottom: false,
          child: Obx(
            () => Column(
              children: [
                if (widget.headerControl != null || _.headerControl != null)
                  ClipRect(
                    clipBehavior: Clip.hardEdge,
                    child: AppBarAni(
                      controller: animationController,
                      visible: !_.controlsLock.value && _.showControls.value,
                      position: 'top',
                      child: widget.headerControl ?? _.headerControl!,
                    ),
                  ),
                const Spacer(),
                ClipRect(
                  child: AppBarAni(
                    controller: animationController,
                    visible: !_.controlsLock.value && _.showControls.value,
                    position: 'bottom',
                    child: widget.bottomControl ??
                        BottomControl(
                          controller: widget.controller,
                          triggerFullScreen:
                              widget.controller.triggerFullScreen,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class PLVideoPlayerController extends GetxController {}
