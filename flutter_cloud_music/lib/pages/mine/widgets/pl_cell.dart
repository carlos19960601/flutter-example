import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/utils/theme_utils.dart';
import 'package:flutter_cloud_music/common/widgets/custom_tap.dart';
import 'package:flutter_cloud_music/models/mine_playlist.dart';

class MinePlaylistCell extends StatelessWidget {
  const MinePlaylistCell({super.key, this.playlist});

  final MinePlaylist? playlist;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: () {},
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: ImageUtils.getImageUrlFromSize(
                playlist?.coverImgUrl,
                const Size(60, 60),
              ),
              errorWidget: playlist != null ? _errorWidget : errorWidget,
              width: 52,
              height: 52,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    (playlist == null || playlist!.isIntelligent())
                        ? '我喜欢的音乐'
                        : playlist!.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: body1Style().copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    playlist?.getCountAndBy() ?? '0首',
                    style: captionStyle(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _errorWidget(
    BuildContext context,
    String url,
    dynamic error,
  ) =>
      ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(7),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Image.asset(
            ImageUtils.getImagePath('cij'),
            color: AppColors.white,
            width: 24,
          ),
        ),
      );
}
