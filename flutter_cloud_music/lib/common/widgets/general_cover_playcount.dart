import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/functions.dart';

class GeneralCoverPlayCount extends StatelessWidget {
  const GeneralCoverPlayCount({
    super.key,
    required this.imageUrl,
    required this.playCount,
    required this.coverSize,
    this.isVideoPl = false,
    this.coverRadius = 6.0,
    this.rightTopTagIcon,
    this.imageCallback,
  });

  final String imageUrl;
  final int playCount;
  final Size coverSize;
  final double coverRadius;
  final String? rightTopTagIcon;
  final bool isVideoPl;
  final ParamSingleCallback<ImageProvider>? imageCallback;

  @override
  Widget build(BuildContext context) {
    return const Column();
  }
}
