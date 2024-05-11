import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/app_extensions.dart';
import 'package:paisa/core/app_storage.dart';
import 'package:paisa/localization/localization_keys.dart';
import 'package:paisa/pages/on_boarding/controller.dart';
import 'package:paisa/pages/on_boarding/widgets/intro_account_add_widget.dart';
import 'package:paisa/pages/on_boarding/widgets/intro_category_add_widget.dart';
import 'package:paisa/pages/on_boarding/widgets/intro_image_picker_widget.dart';
import 'package:paisa/pages/on_boarding/widgets/intro_set_name_widget.dart';

class UserOnboardingPage extends StatefulWidget {
  const UserOnboardingPage({
    super.key,
    this.forceCountrySelector = false,
  });

  final bool forceCountrySelector;

  @override
  State<UserOnboardingPage> createState() => _UserOnboardingPageState();
}

class _UserOnboardingPageState extends State<UserOnboardingPage> {
  Box setting = AppStorage.setting;
  final OnboardingController controller = Get.find<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: [
              Center(
                child: IntroSetNameWidget(
                  formState: controller.formState,
                  nameController: controller.nameController,
                ),
              ),
              IntroImagePickerWidget(),
              const IntroAccountAddWidget(),
              const IntroCategoryAddWidget(),
            ],
          )),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Obx(
                () => Visibility(
                  visible: controller.currentIndex.value != 0,
                  child: FloatingActionButton.extended(
                    heroTag: "backButton",
                    onPressed: controller.prevPage,
                    extendedPadding: const EdgeInsets.symmetric(horizontal: 24),
                    label: Text(
                      LocalizationKeys.back.tr,
                      style: context.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    icon: Icon(MdiIcons.arrowLeft),
                  ),
                ),
              ),
              const Spacer(),
              Obx(
                () => FloatingActionButton.extended(
                  heroTag: "next",
                  onPressed: controller.nextPage,
                  label: Icon(MdiIcons.arrowRight),
                  icon: Text(
                    controller.currentIndex.value == 4
                        ? LocalizationKeys.done.tr
                        : LocalizationKeys.next.tr,
                    style: context.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
