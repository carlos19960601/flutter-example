import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/controller.dart';

class TopOfficialInfoWidget extends StatelessWidget {
  const TopOfficialInfoWidget({super.key, required this.controller});

  final PlaylistDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CachedNetworkImage(
          height: 32,
          fit: BoxFit.contain,
          color: AppColors.white,
          imageUrl: controller.detail.value!.playlist.titleImageUrl!,
          imageBuilder: (context, imageProvider) {
            return ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                child: Image(image: imageProvider),
              ),
            );
          },
        ),
        const SizedBox(
          height: 2,
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 3),
              height: 1,
              width: 15,
              color: AppColors.white.withOpacity(0.4),
            ),
            Text(
              controller.detail.value!.playlist.updateFrequency ?? '',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 13,
              ),
            ),
          ],
        )
      ],
    );
  }
}
