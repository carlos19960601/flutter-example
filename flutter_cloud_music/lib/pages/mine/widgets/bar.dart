import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/delegates/general_sliver_delegate.dart';
import 'package:flutter_cloud_music/pages/mine/controller.dart';
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
                  children: [Expanded(child: Container()), GestureDetector()],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
