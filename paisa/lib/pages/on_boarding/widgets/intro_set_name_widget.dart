import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa/core/app_extensions.dart';
import 'package:paisa/localization/localization_keys.dart';
import 'package:paisa/pages/on_boarding/widgets/intro_image_picker_widget.dart';
import 'package:paisa/widgets/paisa_text_field.dart';

class IntroSetNameWidget extends StatelessWidget {
  const IntroSetNameWidget(
      {super.key, required this.nameController, required this.formState});

  final GlobalKey<FormState> formState;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IntroTopWidget(
            title: LocalizationKeys.image.tr,
            titleWidget: RichText(
              text: TextSpan(
                text: LocalizationKeys.welcome.tr,
                style: context.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.onSurface,
                  letterSpacing: 0.8,
                ),
                children: [
                  TextSpan(
                    text: " ${LocalizationKeys.appTitle.tr}",
                    style: TextStyle(
                      color: context.primary,
                    ),
                  ),
                ],
              ),
            ),
            icon: Icons.wallet,
            description: LocalizationKeys.welcomeDesc.tr,
          ),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: Form(
              key: formState,
              child: PaisaTextFormField(
                key: const Key("user_name_textfield"),
                controller: nameController,
                hintText: LocalizationKeys.enterNameHint.tr,
                label: LocalizationKeys.nameHint.tr,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocalizationKeys.enterNameHint.tr;
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
