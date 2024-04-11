import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/player/widgets/bottom_player_widget.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/home/controller.dart';
import 'package:get/get.dart';

class HomeBottomBar extends StatelessWidget {
  HomeBottomBar({super.key});
  final controller = Get.find<HomeController>();

  Widget _getBarIcon(int index, bool isActive) {
    String path;
    if (index == 0) {
      path = 'icn_discovery';
    } else if (index == 1) {
      path = 'icn_friend';
    } else if (index == 2) {
      path = 'icn_music_new';
    } else if (index == 3) {
      path = 'icn_friend';
    } else {
      path = 'icn_radio_new';
    }

    return ClipOval(
      child: Container(
        width: 25,
        height: 25,
        padding: const EdgeInsets.all(3),
        decoration: isActive
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.appMainLight.withOpacity(0.8),
                    AppColors.appMainLight.withOpacity(0.9),
                    AppColors.appMainLight,
                  ],
                ),
              )
            : null,
        child: Image.asset(
          ImageUtils.getImagePath(path),
          color: isActive ? Colors.white : AppColors.color150,
        ),
      ),
    );
  }

  Text _getBarText(int index) {
    if (index == 0) {
      return const Text("发现", style: TextStyle(fontSize: 11));
    } else if (index == 1) {
      return const Text("歌手", style: TextStyle(fontSize: 11));
    } else if (index == 2) {
      return const Text("我的", style: TextStyle(fontSize: 11));
    } else if (index == 3) {
      return const Text("关注", style: TextStyle(fontSize: 11));
    } else {
      return const Text("云村", style: TextStyle(fontSize: 11));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 48),
          child: const BottomPlayerBar(),
        ),
        Obx(
          () => BottomBar(
            height: 50,
            focusColor: AppColors.appMainLight,
            unFocusColor: AppColors.color150,
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
            items: List<BottomBarItem>.generate(
              3,
              (index) => BottomBarItem(
                icon: _getBarIcon(index, false),
                title: _getBarText(index),
                activeIcon: _getBarIcon(index, true),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
    this.currentIndex = 0,
    required this.height,
    required this.items,
    required this.focusColor,
    required this.unFocusColor,
    required this.onTap,
  });

  final int currentIndex;
  final double height;
  final Color focusColor;
  final Color unFocusColor;
  final List<BottomBarItem> items;
  final ValueChanged<int> onTap;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    for (int i = 0; i < widget.items.length; i += 1) {
      children.add(_createItem(i));
    }

    return SizedBox(
      width: Get.mediaQuery.size.width,
      height: widget.height + Get.mediaQuery.padding.bottom,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Get.theme.cardColor.withOpacity(0.85),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: Get.mediaQuery.padding.bottom,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createItem(int i) {
    final bool selected = i == widget.currentIndex;
    final BottomBarItem item = widget.items[i];

    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: InkResponse(
          onTap: () {
            widget.onTap(i);
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selected) item.activeIcon else item.icon,
                DefaultTextStyle.merge(
                  style: TextStyle(
                    color: selected ? widget.focusColor : widget.unFocusColor,
                  ),
                  child: item.title,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomBarItem {
  final Widget icon;
  final Widget activeIcon;
  final Widget title;

  BottomBarItem({
    required this.icon,
    required this.title,
    required this.activeIcon,
  });
}
