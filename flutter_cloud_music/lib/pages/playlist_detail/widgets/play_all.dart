import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/utils/theme_utils.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/controller.dart';
import 'package:get/get.dart';

class PlDetailPlayAll extends StatelessWidget implements PreferredSizeWidget {
  const PlDetailPlayAll({
    super.key,
    required this.controller,
  });

  final PlaylistDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.cardColor,
      child: Row(
        children: [
          Expanded(child: _buildPlayAll(context)),
          _buildActions(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);

  Widget _buildPlayAll(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.playAll(context);
      },
      child: Container(
        height: preferredSize.height,
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Obx(
              () => Container(
                width: 21,
                height: controller.detail.value?.playlist.specialType != 200
                    ? 21
                    : 18,
                padding: const EdgeInsets.only(left: 2),
                decoration: BoxDecoration(
                  color: AppColors.btnSelectedColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      controller.detail.value?.playlist.specialType != 200
                          ? 12
                          : 7,
                    ),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    ImageUtils.getImagePath("icon_play_small"),
                    color: AppColors.white,
                    width: 12,
                    height: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Obx(
              () => RichText(
                text: TextSpan(
                  text: '播放全部',
                  style: headlineStyle(),
                  children: [
                    TextSpan(
                      text: "(${controller.itemSize.value ?? 0})",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.color150.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Container();
  }
}
