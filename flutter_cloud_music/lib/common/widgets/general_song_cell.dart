import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/models/song_model.dart';
import 'package:get/get.dart';

class GeneralSongCellWidget extends StatelessWidget {
  const GeneralSongCellWidget({super.key, required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: !song.canPlay() ? 0.5 : 1.0,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Column()),
        if ((song.mv ?? -1) > 0)
          GestureDetector(
            child: SizedBox(
              height: 32,
              child: Center(
                child: Image.asset(
                  ImageUtils.getImagePath("video_selected"),
                ),
              ),
            ),
          ),
        GestureDetector(
          child: SizedBox(
            width: 36,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                ImageUtils.getImagePath("cb"),
                height: 24,
                color: Get.isDarkMode
                    ? AppColors.white.withOpacity(0.6)
                    : AppColors.color187,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
