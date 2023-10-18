import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/localization/translation_keys.dart' as translation;
import 'package:paisa/utils/storage.dart';

class CategorySelectorPage extends StatefulWidget {
  const CategorySelectorPage({super.key});

  @override
  State<CategorySelectorPage> createState() => _CategorySelectorPageState();
}

class _CategorySelectorPageState extends State<CategorySelectorPage> {
  Box setting = GStorage.setting;

  Future<void> saveAndNavigate() async {
    await setting.put(SettingBoxKey.userCategorySelectorKey, true);
    if (mounted) {
      // Get.off()
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation.categories.tr),
        titleTextStyle: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
        actions: [
          ElevatedButton(
            onPressed: saveAndNavigate,
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).primaryColor),
            child: Text(
              translation.done.tr,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              translation.addedCategories.tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            title: Text(
              translation.defaultCategories.tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
