import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/utils/theme_utils.dart';
import 'package:flutter_cloud_music/pages/mine/controller.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:get/get.dart';

class MineUserCard extends StatelessWidget {
  MineUserCard({super.key});

  final MineController controller = Get.find<MineController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        afterLogin(() {});
      },
      child: Container(
        height: 135,
        margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              height: 95,
              margin: const EdgeInsets.only(top: 39),
              alignment: Alignment.center,
              decoration: _buildCardBg(context),
              child: _buildNotLogin(context),
            ),
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(35)),
                border: Border.all(color: context.theme.dividerColor),
                boxShadow: [
                  BoxShadow(
                    color: context.theme.shadowColor,
                    blurRadius: 18,
                  ),
                ],
              ),
              child: Obx(
                () => buildUserAvatar(
                  AuthService.to.loginData.value?.profile?.avatarUrl,
                  const Size(70, 70),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotLogin(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: '立即登录 ',
              style: headline1Style().copyWith(fontSize: 20),
            ),
            WidgetSpan(
              child: Image.asset(
                ImageUtils.getImagePath('icon_more'),
                height: 15,
                color: context.iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Decoration _buildCardBg(BuildContext context, {double radius = 16}) {
    return BoxDecoration(
      color: context.theme.cardColor,
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      gradient: Get.isDarkMode
          ? LinearGradient(colors: [
              Colors.white12,
              Colors.white.withOpacity(0.05),
            ])
          : null,
      boxShadow: [
        BoxShadow(
          color: context.theme.shadowColor,
          blurRadius: 18,
        )
      ],
    );
  }
}
