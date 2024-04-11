import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/enums/enum.dart';
import 'package:flutter_cloud_music/common/widgets/general_blur_image.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/controller.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widgets/top_normal_info.dart';
import 'package:get/get.dart';

class PlaylistSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  PlaylistSliverHeaderDelegate({
    required this.controller,
    required this.expendHeight,
    required this.minHeight,
  });

  double expendHeight;
  double minHeight;
  final PlaylistDetailController controller;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double mainHeight = maxExtent - shrinkOffset; //动态高度
    final offset = mainHeight / maxExtent;
    if (controller.detail.value != null) {
      if (offset <= 0.325) {
        controller.titleStatus.value = PlayListTitleStatus.TitleAndBtn;
      } else if (offset >= 0.75) {
        controller.titleStatus.value = PlayListTitleStatus.Normal;
      } else {
        controller.titleStatus.value = PlayListTitleStatus.Title;
      }
    }

    return ClipPath(
      child: _buildTopConver(offset),
    );
  }

  @override
  double get maxExtent => expendHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  Widget _buildTopConver(double offset) {
    return controller.secondOpenOfficial
        ? _buildOfficialCover(offset)
        : _buildNormalCover(offset);
  }

  //官方歌单非首次打开头部
  Widget _buildOfficialCover(double offset) {
    return Obx(() => Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl:
                    controller.detail.value?.playlist.backgroundCoverUrl ?? '',
              ),
            )
          ],
        ));
  }

  //普通歌单头部
  Widget _buildNormalCover(double offset) {
    return Stack(
      children: [
        //背景
        SizedBox(
          width: Get.mediaQuery.size.width,
          height: expendHeight,
          child: Obx(
            () => controller.coverImage.value == null
                ? Container(
                    color: Get.isDarkMode
                        ? Colors.transparent
                        : AppColors.color163,
                  )
                : GeneralBlurImage(
                    sigma: 70,
                    height: expendHeight,
                    image: controller.coverImage.value!,
                  ),
          ),
        ),
        Positioned(
          left: 15,
          right: 26,
          bottom: 50,
          child: _buildClipContent(
            TopNormalInfo(
              controller: controller,
            ),
            offset,
          ),
        ),
      ],
    );
  }

  Widget _buildClipContent(Widget child, double offset) {
    return ClipRect(
      child: Opacity(
        opacity: offset,
        child: child,
      ),
    );
  }
}
