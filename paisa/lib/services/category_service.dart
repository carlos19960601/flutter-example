import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/core/app_storage.dart';
import 'package:paisa/model/category.dart';

class CategoryService extends GetxService {
  final Box setting = AppStorage.setting;
  final Box<CategoryModel> categoryBox = AppStorage.categories;

  late RxList<CategoryModel> categoryList;
  final RxList<CategoryModel> defaultModels = defaultCategories.obs;

  @override
  onInit() {
    super.onInit();
    List<CategoryModel> categories = categoryBox.values.toList();
    categoryList = categories.obs;
  }

  Future<int> add(CategoryModel category) async {
    final CategoryModel copiedCategory = category.copyWith();
    final int id = await categoryBox.add(copiedCategory);
    copiedCategory.superId = id;
    await copiedCategory.save();
    syncCategoryList();

    defaultModels.remove(category);
    defaultModels.refresh();
    return id;
  }

  Future<void> delete(int index) async {
    final CategoryModel category = categoryList.removeAt(index);
    categoryList.refresh();
    await category.delete();
    syncCategoryList();

    defaultModels.add(category);
    defaultModels.refresh();
  }

  syncCategoryList() {
    categoryList.value = categoryBox.values.toList();
  }
}
