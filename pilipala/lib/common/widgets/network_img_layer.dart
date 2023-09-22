import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImgLayer extends StatelessWidget {
  final String? src;
  final double? width;
  final double? height;
  final double? cacheW;
  final double? cacheH;
  final String? type;
  final Duration? fadeOutDuration;
  final Duration? fadeInDuration;
  final int? quality;

  const NetworkImgLayer({
    super.key,
    this.src,
    required this.width,
    required this.height,
    this.cacheW,
    this.cacheH,
    this.type,
    this.fadeOutDuration,
    this.fadeInDuration,
    // 图片质量 默认1%
    this.quality,
  });

  @override
  Widget build(BuildContext context) {
    return src != ""
        ? ClipRect(
            child: CachedNetworkImage(
              imageUrl: src!.startsWith('//') ? 'https:${src!}' : src!,
              width: width ?? double.infinity,
              height: height ?? double.infinity,
              alignment: Alignment.center,
            ),
          )
        : placeholder(context);
  }

  Widget placeholder(context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      child: Center(
        child: Image.asset(
          type == "avatar"
              ? 'assets/images/noface.jpeg'
              : 'assets/images/loading.png',
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
