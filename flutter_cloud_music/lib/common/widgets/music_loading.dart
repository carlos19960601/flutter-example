import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';

class MusicLoading extends StatelessWidget {
  const MusicLoading({super.key, this.axis = Axis.vertical});

  final Axis axis;

  @override
  Widget build(BuildContext context) {
    final bool ver = axis == Axis.vertical;
    if (ver) {
      return Center(
        child: Column(
          children: _loadingContent(ver),
        ),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _loadingContent(ver),
      );
    }
  }

  List<Widget> _loadingContent(bool ver) {
    return [
      if (ver)
        const Expanded(
          child: SizedBox.shrink(),
        ),
      const Text(
        '正在加载中...',
        style: TextStyle(color: AppColors.textGray, fontSize: 13),
      ),
    ];
  }
}
