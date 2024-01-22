import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/controller.dart';
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
            icon: Image.asset(
              ImageUtils.getImagePath('dij'),
              color: AppColors.white.withOpacity(0.9),
              width: 25,
              height: 25,
            ),
          ),
          const Expanded(
            child: Center(),
          ),
        ],
      ),
    );
  }
}
