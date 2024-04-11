import 'dart:async';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:pilipala/plugin/pl_player/controller.dart';

class PlayOrPauseButton extends StatefulWidget {
  final double? iconSize;
  final Color? iconColor;
  final PlPlayerController? controller;
  const PlayOrPauseButton({
    super.key,
    this.iconSize,
    this.iconColor,
    this.controller,
  });

  @override
  State<PlayOrPauseButton> createState() => _PlayOrPauseButtonState();
}

class _PlayOrPauseButtonState extends State<PlayOrPauseButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController animation;
  late Player player;
  StreamSubscription<bool>? subscription;
  bool isOpacity = false;

  @override
  void initState() {
    super.initState();
    player = widget.controller!.videoPlayerController!;
    animation = AnimationController(
      vsync: this,
      value: player.state.playing ? 1 : 0,
      duration: const Duration(
        milliseconds: 200,
      ),
    );
    subscription ??= player.stream.playing.listen((event) {
      if (event) {
        animation.forward().then((value) => {
              isOpacity = true,
            });
      } else {
        animation.reverse().then((value) => {isOpacity = false});
      }
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 为什么要放到 didChangeDependencies？
    // subscription ??= player.stream.playing.listen((event) {
    //   if (event) {
    //     animation.forward().then((value) => {
    //           isOpacity = true,
    //         });
    //   } else {
    //     animation.reverse().then((value) => {isOpacity = false});
    //   }
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    animation.dispose();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      width: 34,
      child: IconButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        color: Colors.white,
        iconSize: 20,
        onPressed: player.playOrPause,
        icon: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: animation,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
