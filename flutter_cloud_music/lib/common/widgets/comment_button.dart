import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';

class CommentButton extends StatelessWidget {
  const CommentButton({super.key, required this.songId});

  final String songId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.asset(
        ImageUtils.getImagePath('detail_icn_cmt'),
        width: 24,
        color: AppColors.color217,
      ),
    );
  }
}
