import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/video/controller/video_list_controller.dart';

class VideoContent extends StatelessWidget {
  const VideoContent({
    super.key,
    required this.videoController,
    required this.video,
    required this.rightButtonColumn,
    required this.userInfoWidget,
    this.onCommentTap,
  });

  final Widget video;
  final Widget rightButtonColumn;
  final Widget userInfoWidget;

  final VPVideoController videoController;
  final Function? onCommentTap;

  @override
  Widget build(BuildContext context) {
    final videoContainer = Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          alignment: Alignment.center,
          child: video,
        ),
      ],
    );
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  videoContainer,
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.bottomRight,
                    child: rightButtonColumn,
                  ),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.bottomLeft,
                    child: userInfoWidget,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                onCommentTap?.call();
              },
              child: Container(
                width: double.infinity,
                height: 49,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '千言万语，汇成评论一句',
                      style: TextStyle(
                        color: Colors.white30,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
