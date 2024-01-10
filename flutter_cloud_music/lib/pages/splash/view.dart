import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/splash/controller.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appMain,
      body: Container(
        padding: EdgeInsets.only(top: controller.isFirst ? 100 : 255),
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (controller.isFirst) {
      return Image.asset(
        'assets/anim/cif.webp',
      );
    }

    return Image.asset(
      ImageUtils.getImagePath("erq"),
      width: 100,
      height: 100,
    );
  }
}
