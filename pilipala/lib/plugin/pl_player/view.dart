import 'package:flutter/material.dart';
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

class _PLVideoPlayerState extends State<PLVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [],
    );
  }
}
