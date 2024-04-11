import 'package:flutter/material.dart';
import 'package:pilipala/common/skeleton/skeleton.dart';

class VideoCardVSkeleton extends StatelessWidget {
  const VideoCardVSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        child: Column(
      children: [Text("测试...")],
    ));
  }
}
