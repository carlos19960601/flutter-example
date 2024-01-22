import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralBlurImage extends StatelessWidget {
  const GeneralBlurImage({
    super.key,
    required this.image,
    required this.sigma,
    required this.height,
  });

  final ImageProvider image;
  final double height;
  final double sigma;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image(
          width: Get.mediaQuery.size.width,
          image: image,
          fit: BoxFit.cover,
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
            child: Container(
              color: Colors.black12,
              width: Get.mediaQuery.size.width,
              height: height,
            ),
          ),
        )
      ],
    );
  }
}
