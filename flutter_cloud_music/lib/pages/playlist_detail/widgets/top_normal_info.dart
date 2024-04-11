import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
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
            coverRadius: 8,
            imageCallback: (ImageProvider provider) async {
              await Future.delayed(const Duration(milliseconds: 100));
              controller.coverImage.value = provider;
            },
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
                      style: TextStyle(
                        fontSize: 16,
                        color: Get.isDarkMode
                            ? AppColors.white.withOpacity(0.9)
                            : AppColors.white,
                      ),
                    ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          GestureDetector(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: controller.detail.value?.playlist
                                        .creator.nickname,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.white.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Row(
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 160,
                          ),
                          child: Text(
                            controller.detail.value?.playlist.description
                                    ?.replaceAll(
                                        RegExp(r'\s+\b|\b\s|\n'), ' ') ??
                                '暂无简介',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.white.withOpacity(0.7),
                            ),
                          ),
                        ),
                        Image.asset(
                          ImageUtils.getImagePath('icon_more'),
                          height: 13,
                          width: 13,
                          color: AppColors.white.withOpacity(0.65),
                        ),
                      ],
                    ),
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
