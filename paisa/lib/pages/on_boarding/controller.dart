import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paisa/core/app_storage.dart';
import 'package:paisa/model/account.dart';

class OnboardingController extends GetxController {
  final Box setting = AppStorage.setting;
  final Box<AccountModel> accounts = AppStorage.accounts;
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  RxInt currentIndex = 0.obs;
  RxString imagePath = ''.obs;

  prevPage() {
    if (currentIndex.value != 0) {
      currentIndex - 1;
    }
  }

  nextPage() {
    if (currentIndex.value == 0) {
      if (formState.currentState!.validate()) {
        saveName();
      }
    } else if (currentIndex.value == 1) {
      saveImage();
    } else if (currentIndex.value == 2) {
      saveAccountAndNavigate();
    } else if (currentIndex.value == 3) {
      saveCategoryAndNavigate();
    } else if (currentIndex.value == 4) {}
  }

  void saveName() {
    if (formState.currentState!.validate()) {
      setting.put(SettingBoxKey.userNameKey, nameController.text);
      currentIndex.value = 1;
    }
  }

  saveImage() {
    if (formState.currentState!.validate()) {
      final String image =
          setting.get(SettingBoxKey.userImageKey, defaultValue: "");
      if (image.isEmpty) {
        setting.put(SettingBoxKey.userImageKey, 'no-image');
      }
      currentIndex.value = 2;
    }
  }

  Future<void> saveAccountAndNavigate() async {
    await setting.put(SettingBoxKey.userAccountSelectorKey, false);
    currentIndex.value = 3;
  }

  Future<void> saveCategoryAndNavigate() async {
    await setting.put(SettingBoxKey.userCategorySelectorKey, false);
    currentIndex.value = 4;
  }

  pickImage(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((pickedFile) {
      if (pickedFile != null) {
        setting.put(SettingBoxKey.userImageKey, pickedFile.path);
        imagePath.value = pickedFile.path;
      }
    });
  }

  deleteImage() {
    setting.put(SettingBoxKey.userImageKey, "");
    imagePath.value = "";
  }
}
