import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/common/default_category.dart';
import 'package:paisa/localization/translation_keys.dart' as translation;
import 'package:paisa/model/category.dart';
import 'package:paisa/pages/account_selector/view.dart';
import 'package:paisa/pages/category_selector/widgets/category_item.dart';
import 'package:paisa/utils/storage.dart';

class CategorySelectorPage extends StatefulWidget {
  const CategorySelectorPage({super.key});

  @override
  State<CategorySelectorPage> createState() => _CategorySelectorPageState();
}

class _CategorySelectorPageState extends State<CategorySelectorPage> {
  Box setting = GStorage.setting;
  Box categories = GStorage.categories;
  late List<CategoryModel> defaultModels;

  Future<void> saveAndNavigate() async {
    await setting.put(SettingBoxKey.userCategorySelectorKey, true);
    if (mounted) {
      Get.off(() => const AccountSelectorPage());
    }
  }

  @override
  void initState() {
    super.initState();
    List<String> selected = categories.values.map((e) {
      CategoryModel model = e as CategoryModel;
      return model.name ?? "";
    }).toList();
    defaultModels = defaultCategoriesData
        .where((element) => !selected.contains(element.name))
        .toList();
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
          ValueListenableBuilder(
            valueListenable: categories.listenable(),
            builder: (context, box, child) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    CategoryModel model = box.getAt(index) as CategoryModel;
                    return CategoryItemWidget(
                        model: model,
                        onPress: () {
                          box.deleteAt(index);
                          setState(() {
                            defaultModels.add(model);
                          });
                        });
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: box.values.length,
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              translation.defaultCategories.tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: defaultModels
                  .map(
                    (model) => FilterChip(
                      onSelected: (value) {
                        setState(() {
                          defaultModels.remove(model);
                        });
                        categories.add(model);
                      },
                      label: Text(model.name ?? ""),
                      labelStyle: Theme.of(context).textTheme.titleMedium,
                      padding: const EdgeInsets.all(12),
                      avatar: Icon(
                        IconData(model.icon ?? 0, fontFamily: 'MaterialIcons'),
                        color: Theme.of(context).primaryColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
