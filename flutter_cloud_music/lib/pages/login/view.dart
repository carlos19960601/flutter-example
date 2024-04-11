import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/utils/theme_utils.dart';
import 'package:flutter_cloud_music/pages/login/controller.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appMain,
      appBar: AppBar(
        leadingWidth: 46,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            child: Image.asset(
              ImageUtils.getImagePath('login_icn_back'),
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 80),
          Center(
            child: Image.asset(
              ImageUtils.getImagePath('e18'),
              fit: BoxFit.cover,
              width: 76,
              height: 76,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.offAndToNamed(Routes.PHONE_LOGIN);
            },
            child: Container(
              height: 46,
              margin: const EdgeInsets.only(top: 150, left: 48, right: 48),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(28),
                ),
              ),
              child: const Center(
                child: Text(
                  "手机号登陆",
                  style: TextStyle(
                    color: AppColors.appMainLight,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 36),
          Center(
            child: Text(
              "本项目仅供学习，请尊重版权",
              style: body1Style().copyWith(color: Colors.white54, fontSize: 13),
            ),
          ),
          const SizedBox(height: 100),
          Center(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.EMAIL_LOGIN);
              },
              child: ClipOval(
                child: Container(
                  width: 38,
                  height: 38,
                  color: Colors.white,
                  padding: const EdgeInsets.all(4),
                  child: Center(
                    child: Image.asset(ImageUtils.getImagePath("login_163")),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
