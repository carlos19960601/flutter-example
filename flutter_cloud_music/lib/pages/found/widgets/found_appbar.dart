import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/found/controller.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:get/get.dart';

class FoundAppbar extends StatelessWidget implements PreferredSizeWidget {
  FoundAppbar({super.key});

  final FoundController controller = Get.find<FoundController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SEARCH,
                    arguments: controller.defuleSearch.value);
              },
              child: Obx(
                () => Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  margin: const EdgeInsets.only(left: 56, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(18),
                    ),
                    color: controller.isScrolled.value
                        ? Get.isDarkMode
                            ? Colors.white12
                            : Colors.grey.shade100
                        : Get.isDarkMode
                            ? Colors.white12
                            : Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Image.asset(
                              ImageUtils.getImagePath("search"),
                              color: const Color.fromARGB(255, 134, 135, 134),
                              width: 15,
                              height: 15,
                            ),
                          ),
                        ),
                        const TextSpan(
                          text: "搜索",
                          style: TextStyle(
                            color: AppColors.textGray,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            child: Icon(
              Icons.keyboard_voice,
              color: Get.isDarkMode
                  ? AppColors.darkBody2TxtColor
                  : AppColors.body2TxtColor,
              size: 25,
            ),
          ),
          const SizedBox(width: 14),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
