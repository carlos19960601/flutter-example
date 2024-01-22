import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/widgets/general_cover_playcount.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/controller.dart';
import 'package:get/get.dart';

class TopNormalInfo extends StatelessWidget {
  const TopNormalInfo({super.key, required this.controller});

  final PlaylistDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          GeneralCoverPlayCount(
            imageUrl: controller.detail.value?.playlist.coverImgUrl ?? '',
            playCount: controller.detail.value?.playlist.playCount ?? 0,
            coverSize: const Size(122, 122),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: SizedBox(
              height: 122,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.detail.value?.playlist.name != null)
                    Text(
                      controller.detail.value?.playlist.name ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
