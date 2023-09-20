import 'package:flutter/material.dart';

class VideoReplyPanel extends StatefulWidget {
  final String? bvid;
  final int rpid;
  final String? replyLevel;

  const VideoReplyPanel({
    this.bvid,
    this.rpid = 0,
    this.replyLevel,
    super.key,
  });

  @override
  State<VideoReplyPanel> createState() => _VideoReplyPanelState();
}

class _VideoReplyPanelState extends State<VideoReplyPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
