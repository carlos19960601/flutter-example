import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/singer_detail/controller.dart';
import 'package:get/get.dart';

class SingerHeader extends StatelessWidget {
  const SingerHeader({
    super.key,
    required this.controller,
  });

  final SingerDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Get.theme.cardColor,
                Get.theme.scaffoldBackgroundColor,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }
}
