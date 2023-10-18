import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa/localization/translation_keys.dart' as translation;

class IntroSetNameWidget extends StatelessWidget {
  const IntroSetNameWidget(
      {super.key, required this.nameController, required this.formState});

  final GlobalKey<FormState> formState;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 16),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor, BlendMode.srcIn),
            child: const Icon(
              Icons.wallet,
              size: 72,
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              text: translation.welcome.tr,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                    letterSpacing: 0.8,
                  ),
              children: [
                TextSpan(
                  text: ' ${translation.appTitle.tr}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            translation.welcomeDesc.tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
                  letterSpacing: 0.6,
                ),
          ),
          const SizedBox(height: 16),
          Form(
            key: formState,
            child: TextFormField(
              controller: nameController,
              // keyboardType: TextInputType.none,
              textCapitalization: TextCapitalization.none,
              decoration: InputDecoration(
                counterText: "",
                hintText: translation.enterNameHint.tr,
                label: Text(
                  translation.nameHint.tr,
                ),
              ),
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return translation.enterNameHint.tr;
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
