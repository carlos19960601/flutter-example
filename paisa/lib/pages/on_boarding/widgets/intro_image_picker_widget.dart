import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paisa/localization/translation_keys.dart' as translation;
import 'package:paisa/utils/storage.dart';

class IntroImagePickerWidget extends StatefulWidget {
  const IntroImagePickerWidget({super.key});

  @override
  State<IntroImagePickerWidget> createState() => _IntroImagePickerWidgetState();
}

class _IntroImagePickerWidgetState extends State<IntroImagePickerWidget> {
  Box setting = GStorage.setting;
  late String image;

  pickImage(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((pickedFile) {
      if (pickedFile != null) {
        setting.put(SettingBoxKey.userImageKey, pickedFile.path);
        setState(() {
          image = pickedFile.path;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    image = setting.get(SettingBoxKey.userImageKey, defaultValue: "");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 16),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColor,
              BlendMode.srcIn,
            ),
            child: const Icon(
              Icons.person_add_rounded,
              size: 72,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            translation.image.tr,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          Text(
            translation.imageDesc.tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 16),
          Center(
            child: GestureDetector(
              onTap: () => pickImage(context),
              child: Builder(
                builder: (context) {
                  if (image.isEmpty) {
                    return CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      maxRadius: 72,
                      child: Icon(
                        Icons.account_circle_outlined,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    );
                  } else {
                    return CircleAvatar(
                      foregroundImage: FileImage(File(image)),
                      maxRadius: 72,
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
