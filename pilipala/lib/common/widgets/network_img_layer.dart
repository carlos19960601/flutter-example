import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/common/constants.dart';
import 'package:pilipala/utils/storage.dart';

Box setting = GStorage.setting;

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
  final double? origAspectRatio;

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
    this.origAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    int picQuality = setting.get(SettingBoxKey.defaultPicQa, defaultValue: 10);

    return src != ""
        ? ClipRRect(
            borderRadius: BorderRadius.circular(type == "avatar"
                ? 50
                : type == "emote"
                    ? 0
                    : StyleString.imgRadius.x),
            child: CachedNetworkImage(
              imageUrl:
                  '${src!.startsWith('//') ? 'https:${src!}' : src!}@${quality ?? picQuality}q.webp',
              width: width ?? double.infinity,
              height: height ?? double.infinity,
              alignment: Alignment.center,
              fit: BoxFit.cover,
              placeholder: (context, url) => placeholder(context),
              errorWidget: (context, url, err) => placeholder(context),
            ),
          )
        : placeholder(context);
  }

  Widget placeholder(context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
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
