import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/enums/enum.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/controller.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/models/playlist_detail_model.dart';
import 'package:get/get.dart';

class PlaylistTopAppbar extends StatefulWidget {
  const PlaylistTopAppbar({
    super.key,
    required this.appBarHeight,
    required this.controller,
  });

  final double appBarHeight;
  final PlaylistDetailController controller;

  @override
  State<PlaylistTopAppbar> createState() => _PlaylistTopAppbarState();
}

class _PlaylistTopAppbarState extends State<PlaylistTopAppbar> {
  PlayListTitleStatus _titleStatus = PlayListTitleStatus.Normal;

  @override
  void initState() {
    super.initState();
    widget.controller.titleStatus.listen((p0) {
      Future.delayed(const Duration(milliseconds: 100)).whenComplete(() {
        setState(() {
          _titleStatus = p0;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: context.mediaQueryPadding.top),
      height: widget.appBarHeight,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            padding: const EdgeInsets.only(left: 2),
            icon: Image.asset(
              ImageUtils.getImagePath('dij'),
              color: AppColors.white.withOpacity(0.9),
              width: 25,
              height: 25,
            ),
          ),
          Expanded(
            child: Center(
              child: Obx(
                () => _buildTitle(_titleStatus, widget.controller.detail.value),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              ImageUtils.getImagePath('cb'),
              color: AppColors.white.withOpacity(0.9),
              width: 25,
              height: 25,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTitle(
      PlayListTitleStatus value, PlaylistDetailModel? detailModel) {
    switch (value) {
      case PlayListTitleStatus.Normal:
        return RichText(
          text: TextSpan(
            children: [
              if (detailModel?.isOfficial() == true)
                WidgetSpan(
                  child: Image.asset(
                    ImageUtils.getImagePath('capture_logo'),
                    width: 20,
                    color: Colors.white,
                  ),
                ),
              TextSpan(
                text: detailModel?.isOfficial() == true
                    ? ' 官方动态歌单'
                    : detailModel?.getTypename(),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        );
      case PlayListTitleStatus.Title:
        return Text(
          detailModel?.playlist.name ?? "",
          style: const TextStyle(fontSize: 17, color: Colors.white),
        );
      case PlayListTitleStatus.TitleAndBtn:
        return Row(
          children: [
            Expanded(
              child: Text(
                detailModel?.playlist.name ?? "",
                style: const TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
            Container(
              height: 24,
              margin: const EdgeInsets.only(left: 15),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 9),
              decoration: BoxDecoration(
                color: AppColors.appMainLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 13,
                  ),
                  Text(
                    '收藏',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ],
        );
    }
  }
}
