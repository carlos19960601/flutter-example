import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/utils/theme_utils.dart';
import 'package:flutter_cloud_music/delegates/general_sliver_delegate.dart';
import 'package:flutter_cloud_music/pages/mine/controller.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:get/get.dart';

class MineViewBar extends StatelessWidget {
  MineViewBar({super.key});

  final MineController controller = Get.find<MineController>();

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: GeneralSliverDelegate(
        child: PreferredSize(
          preferredSize: Size.fromHeight(controller.barHeight),
          child: Obx(
            () => Container(
              padding: EdgeInsets.only(
                right: 16,
                top: Get.mediaQuery.padding.top + 4,
              ),
              color: Get.theme.cardColor.withOpacity(
                controller.barBgOpacity.value,
              ),
              child: SizedBox(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        child: controller.barBgOpacity.value >= 1.0
                            ? GestureDetector(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    buildUserAvatar(
                                      AuthService.to.loginData.value?.profile
                                          ?.avatarUrl,
                                      const Size(24, 24),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      AuthService.to.loginData.value?.profile
                                              ?.nickname ??
                                          '',
                                      style: headline1Style(),
                                    ),
                                  ],
                                ),
                              )
                            : null,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.SEARCH);
                      },
                      child: Image.asset(
                        ImageUtils.getImagePath("search"),
                        color: context.iconColor,
                        height: 24,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
