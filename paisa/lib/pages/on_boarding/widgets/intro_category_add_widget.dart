import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/app_extensions.dart';
import 'package:paisa/core/app_fonts.dart';
import 'package:paisa/localization/localization_keys.dart';
import 'package:paisa/model/category.dart';
import 'package:paisa/pages/on_boarding/widgets/intro_image_picker_widget.dart';
import 'package:paisa/routes/app_routes.dart';
import 'package:paisa/services/category_service.dart';
import 'package:paisa/widgets/paisa_card.dart';

class IntroCategoryAddWidget extends StatefulWidget {
  const IntroCategoryAddWidget({super.key});

  @override
  State<IntroCategoryAddWidget> createState() => _IntroCategoryAddWidgetState();
}

class _IntroCategoryAddWidgetState extends State<IntroCategoryAddWidget> {
  final CategoryService categoryService = Get.find<CategoryService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          IntroTopWidget(
            title: LocalizationKeys.addCategory.tr,
            icon: Icons.category,
          ),
          Obx(
            () => PaisaFilledCard(
              child: ListView.separated(
                shrinkWrap: true,
                // 确保这个ListView不会单独滚动
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final CategoryModel model =
                      categoryService.categoryList[index];

                  return CategoryItemWidget(
                    model: model,
                    onPress: () => categoryService.delete(index),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: categoryService.categoryList.length,
              ),
            ),
          ),
          ListTile(
            title: Text(
              LocalizationKeys.recommendedCategories.tr,
              style: context.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Obx(
              () => Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ...categoryService.defaultModels
                      .sorted((a, b) => a.name!.compareTo(b.name!))
                      .map(
                        (e) => FilterChip(
                          label: Text(e.name ?? ""),
                          labelStyle: context.titleMedium,
                          padding: const EdgeInsets.all(12),
                          onSelected: (value) {
                            categoryService.add(e);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                            side: BorderSide(
                              width: 1,
                              color: context.primary,
                            ),
                          ),
                          showCheckmark: false,
                          avatar: Icon(
                            IconData(
                              e.icon ?? 0,
                              fontFamily: AppFonts.fontName,
                              fontPackage: AppFonts.fontPackage,
                            ),
                            color: context.primary,
                          ),
                        ),
                      )
                      .toList(),
                  FilterChip(
                    selected: false,
                    onSelected: (value) {
                      Get.to(AppRoutes.addCategory);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                      side: BorderSide(
                        width: 1,
                        color: context.primary,
                      ),
                    ),
                    showCheckmark: false,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    label: Text(LocalizationKeys.addCategory.tr),
                    labelStyle: context.titleMedium,
                    padding: const EdgeInsets.all(12),
                    avatar: Icon(
                      Icons.add_rounded,
                      color: context.primary,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.model,
    required this.onPress,
  });

  final CategoryModel model;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Icon(
        IconData(
          model.icon ?? 0,
          fontFamily: AppFonts.fontName,
          fontPackage: AppFonts.fontPackage,
        ),
        color: Color(model.color ?? Colors.brown.shade200.value),
      ),
      title: Text(model.name ?? ""),
      trailing: Icon(MdiIcons.delete),
    );
  }
}
