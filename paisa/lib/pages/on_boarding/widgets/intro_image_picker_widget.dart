import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/core/app_extensions.dart';
import 'package:paisa/core/app_storage.dart';
import 'package:paisa/localization/localization_keys.dart';
import 'package:paisa/pages/on_boarding/controller.dart';
import 'package:paisa/widgets/paisa_user_image_widget.dart';

class IntroImagePickerWidget extends StatelessWidget {
  IntroImagePickerWidget({super.key});
  final Box setting = AppStorage.setting;
  final OnboardingController controller = Get.find<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IntroTopWidget(
            title: LocalizationKeys.image.tr,
            icon: Icons.camera_enhance,
            description: LocalizationKeys.imageDesc.tr,
          ),
          Center(
            child: Obx(() => PaisaUserImageWidget(
                  pickImage: () => controller.pickImage(context),
                  deleteImage: () => controller.deleteImage(),
                  maxRadius: 72,
                  useDefault: true,
                  imagePath: controller.imagePath.value,
                )),
          )
        ],
      ),
    );
  }
}

class IntroTopWidget extends StatelessWidget {
  const IntroTopWidget({
    super.key,
    required this.title,
    this.titleWidget,
    this.description,
    required this.icon,
  });

  final String? description;
  final IconData icon;
  final String title;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              context.primary,
              BlendMode.srcIn,
            ),
            child: Icon(
              icon,
              size: 72,
            ),
          ),
          const SizedBox(height: 16),
          titleWidget ??
              Text(
                title,
                style: context.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
          if (description != null)
            Text(
              description!,
              style: context.titleSmall?.copyWith(
                color: context.onSurface.withOpacity(0.75),
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
