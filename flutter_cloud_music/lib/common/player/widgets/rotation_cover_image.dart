import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/models/song_model.dart';

class RotationCoverImage extends StatefulWidget {
  const RotationCoverImage({
    super.key,
    required this.rotating,
    required this.padding,
    this.music,
  });

  final bool rotating;
  final Song? music;
  final double padding;

  @override
  State<RotationCoverImage> createState() => _RotationCoverImageState();
}

class _RotationCoverImageState extends State<RotationCoverImage>
    with SingleTickerProviderStateMixin {
  //album cover rotation
  double rotation = 0;

  //album cover rotation animation
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..addListener(() {
            setState(() {
              rotation = controller.value * 2 * pi;
            });
          })
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed && controller.value == 1) {
              controller.forward(from: 0);
            }
          });

    if (widget.rotating) {
      controller.forward(from: controller.value);
    }
  }

  @override
  void didUpdateWidget(covariant RotationCoverImage oldWidget) {
    if (widget.music != oldWidget.music) {
      controller.value = 0;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageUtils.getImagePath("play_disc"),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(widget.padding),
              child: Transform.rotate(
                angle: rotation,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: widget.music?.al.picUrl ?? "",
                    placeholder: (context, url) => Image.asset(
                        ImageUtils.getImagePath("default_cover_play")),
                    errorWidget: (context, url, error) => Image.asset(
                        ImageUtils.getImagePath("default_cover_play")),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
