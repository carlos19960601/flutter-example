import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
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

  late RxList<AccountModel> accountList;

  @override
  onInit() {
    super.onInit();
    accountList = accounts.values.toList().obs;
  }

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
      // Get.off(() => const CategorySelectorPage());
    }
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
