import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/bottom_player_controller.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';

class BottomPlayerBar extends StatefulWidget {
  const BottomPlayerBar({
    super.key,
    this.bottomPadding = 0,
  });

  final double bottomPadding;

  @override
  State<BottomPlayerBar> createState() => _BottomPlayerBarState();
}

class _BottomPlayerBarState extends State<BottomPlayerBar> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        toPlaying();
      },
      child: MediaQuery(
        data: context.mediaQuery.copyWith(
            viewInsets: context.mediaQueryViewInsets.copyWith(bottom: 0)),
        child: Obx(
          () => _BottomContentWidget(
            listSize: context.playerService.queueSizeValue.value,
            bottomPadding: widget.bottomPadding,
            curPlayId: context.playerService.curPlayId.value,
          ),
        ),
      ),
    );
  }
}

class _BottomContentWidget extends GetView<PlayerContoller> {
  const _BottomContentWidget({
    super.key,
    required this.listSize,
    required this.bottomPadding,
    this.curPlayId,
  });

  final double bottomPadding;
  final int? curPlayId;
  final int listSize;

  @override
  Widget build(BuildContext context) {
    Get.put(PlayerContoller());

    if (curPlayId == null || (curPlayId ?? -1) < 0) {
      return const SizedBox.shrink();
    }

    final backgroundColor = Get.theme.cardColor;
    final PlayQueue queue = context.player.queue;
    return SizedBox(
      height: 58 + bottomPadding,
      width: Get.mediaQuery.size.width,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Get.theme.dividerColor,
                    width: 1,
                  ),
                ),
              ),
              margin: const EdgeInsets.only(top: 5),
            ),
          ),
          //背景
          Positioned(
            top: 6,
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: backgroundColor.withOpacity(0.8),
                ),
              ),
            ),
          ),
          //内容
          Positioned.fill(
            bottom: bottomPadding,
            child: Row(
              children: [
                Expanded(
                  child: _buildNormWidget(context.curPlayRx.value!.metadata),
                ),
                const SizedBox(width: 12),
                Container(
                  margin: const EdgeInsets.only(top: 7),
                  child: Image.asset(
                    ImageUtils.getImagePath("epj"),
                    width: 40,
                    height: 40,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNormWidget(MusicMetadata music) {
    return const Row();
  }
}
