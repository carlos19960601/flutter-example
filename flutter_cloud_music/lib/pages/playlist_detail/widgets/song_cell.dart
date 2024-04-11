import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/functions.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/widgets/general_song_cell.dart';
import 'package:flutter_cloud_music/models/song_model.dart';
import 'package:get/get.dart';

class NumSongCell extends StatelessWidget {
  const NumSongCell({
    super.key,
    required this.song,
    required this.index,
    required this.clickCallback,
    this.needBgColor = true,
  });

  final Song song;
  final int index;
  final bool needBgColor;
  final ParamVoidCallback clickCallback;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size.fromHeight(60),
      child: Material(
        color: needBgColor ? Get.theme.cardColor : Colors.transparent,
        child: InkWell(
          onTap: () {
            clickCallback.call();
          },
          child: Row(
            children: [
              Container(
                width: 40,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Center(
                  child: Obx(
                    () => context.playerService.curPlayId.value == song.id
                        ? Image.asset(
                            ImageUtils.getPlayingMusicTag(),
                            width: 13,
                            color: AppColors.btnSelectedColor,
                          )
                        : AutoSizeText(
                            '${index + 1}',
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 16,
                              color: Get.isDarkMode
                                  ? AppColors.white.withOpacity(0.4)
                                  : AppColors.color156,
                            ),
                          ),
                  ),
                ),
              ),
              Expanded(
                child: GeneralSongCellWidget(song: song),
              )
            ],
          ),
        ),
      ),
    );
  }
}
