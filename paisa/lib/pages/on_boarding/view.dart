import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/localization/translation_keys.dart' as translation;
import 'package:paisa/pages/category_selector/view.dart';
import 'package:paisa/pages/on_boarding/widgets/intro_image_picker_widget.dart';
import 'package:paisa/pages/on_boarding/widgets/intro_set_name_widget.dart';
import 'package:paisa/utils/storage.dart';

class UserOnboardingPage extends StatefulWidget {
  const UserOnboardingPage({super.key});

  @override
  State<UserOnboardingPage> createState() => _UserOnboardingPageState();
}

class _UserOnboardingPageState extends State<UserOnboardingPage> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  int currentIndex = 0;
  Box setting = GStorage.setting;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        controller: _pageController,
        children: [
          IntroSetNameWidget(
            formState: _formState,
            nameController: _nameController,
          ),
          const IntroImagePickerWidget(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Visibility(
                visible: currentIndex != 0,
                child: FloatingActionButton.extended(
                  // if not set heroTag, please see https://stackoverflow.com/questions/51125024/there-are-multiple-heroes-that-share-the-same-tag-within-a-subtree
                  heroTag: null,
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  },
                  extendedPadding: const EdgeInsets.symmetric(horizontal: 24),
                  label: Text(
                    "Back",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                  ),
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              const Spacer(),
              FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {
                  if (currentIndex == 0) {
                    if (_formState.currentState!.validate()) {
                      setting.put(
                          SettingBoxKey.userNameKey, _nameController.text);
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    }
                  } else if (currentIndex == 1) {
                    final String image = setting.get(SettingBoxKey.userImageKey,
                        defaultValue: "");
                    if (image.isEmpty) {
                      setting.put(SettingBoxKey.userImageKey, "no-image");
                    }
                    Get.off(() => const CategorySelectorPage());
                  }
                },
                label: const Icon(Icons.arrow_forward),
                icon: Text(
                  translation.next.tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
