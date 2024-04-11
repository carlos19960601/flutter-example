import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/video/controller/video_list_controller.dart';

class VideoRightButtons extends StatelessWidget {
  const VideoRightButtons({
    super.key,
    required this.controller,
  });

  final VPVideoController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      margin: const EdgeInsets.only(bottom: 25, right: 10),
      child: const Column(
        children: [],
      ),
    );
  }
}
