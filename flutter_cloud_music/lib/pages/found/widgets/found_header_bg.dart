import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/found/controller.dart';
import 'package:get/get.dart';

class FoundHeaderColors extends StatefulWidget {
  const FoundHeaderColors({super.key});

  @override
  State<FoundHeaderColors> createState() => _FoundHeaderColorsState();
}

class _FoundHeaderColorsState extends State<FoundHeaderColors>
    with SingleTickerProviderStateMixin {
  final FoundController _foundController = Get.find<FoundController>();

  late AnimationController _animationController;
  late Animation<Color?> _colors;
  Color curColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _colors = ColorTween(begin: curColor, end: Colors.transparent)
        .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: Get.mediaQuery.size.width,
        height: kToolbarHeight + Get.mediaQuery.padding.top,
        child: _foundController.isScrolled.value
            ? Container(
                color: Get.theme.cardColor,
                height: kToolbarHeight + Get.mediaQuery.padding.top,
                width: Get.mediaQuery.size.width,
              )
            : Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: _colors.value,
                    ),
                  ),
                  Positioned.fill(
                    child: Obx(
                      () => _foundController.isSucLoad.value
                          ? Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Get.theme.cardColor.withOpacity(0.8),
                                    Get.theme.cardColor,
                                    Get.theme.cardColor,
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
