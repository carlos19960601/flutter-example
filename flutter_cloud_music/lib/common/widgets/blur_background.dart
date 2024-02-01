import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';

class BlurBackground extends StatelessWidget {
  const BlurBackground({
    super.key,
    this.musicCoverUrl,
  });

  final String? musicCoverUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 55, sigmaY: 55),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: musicCoverUrl ?? "",
              fit: BoxFit.fitHeight,
              placeholder: (context, url) {
                return Image.asset(
                  ImageUtils.getImagePath("fm_bg", format: "jpg"),
                  fit: BoxFit.fitHeight,
                );
              },
              errorWidget: (context, url, error) {
                return Image.asset(
                  ImageUtils.getImagePath("fm_bg", format: "jpg"),
                  fit: BoxFit.fitHeight,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
