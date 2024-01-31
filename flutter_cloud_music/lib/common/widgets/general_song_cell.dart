import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/utils/theme_utils.dart';
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
    final TextStyle titleStyle = body1Style().copyWith(fontSize: 17);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 232),
                    child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: song.name,
                        style: titleStyle,
                        children: [
                          if (song.alia.isNotEmpty)
                            TextSpan(
                              text:
                                  "(${song.alia.reduce((value, element) => '$value $element')})",
                              style: captionStyle().copyWith(fontSize: 17),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (GetUtils.isNullOrBlank(song.reason) != true)
                    Expanded(
                      child: Container(
                        height: 15,
                        margin: const EdgeInsets.only(left: 4),
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Text(
                            song.reason!,
                            style: const TextStyle(
                              color: AppColors.appMain,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: getSongTags(song,
                        needOriginType: false,
                        needNewType: false,
                        needCopyright: false),
                  ),
                  Expanded(
                    child: Text(
                      song.getSongCellSubTitle(),
                      style: captionStyle(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
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
