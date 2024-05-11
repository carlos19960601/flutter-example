import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class CategoryModel extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? description;
  @HiveField(2)
  int? icon;
  @HiveField(3, defaultValue: false)
  bool? isDefault;
  @HiveField(4, defaultValue: 0)
  int? superId;
  @HiveField(5, defaultValue: 0)
  double? budget;
  @HiveField(6, defaultValue: false)
  bool? isBudget;
  @HiveField(7, defaultValue: 0xFFFFC107)
  int? color;

  CategoryModel({
    this.name,
    this.description,
    this.icon,
    this.isDefault = false,
    this.superId,
    this.budget = -1,
    this.isBudget = false,
    this.color,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        icon: json["icon"],
        name: json["name"],
        color: json["color"],
        description: json["description"],
        budget: json["budget"],
        isDefault: json["isDefault"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "icon": icon,
        "budget": budget,
        "color": color,
        "isBudget": isBudget,
        "isDefault": isDefault,
      };

  CategoryModel copyWith({
    String? name,
    String? description,
    int? icon,
    bool? isDefault,
    int? superId,
    double? budget,
    bool? isBudget,
    int? color,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

final List<CategoryModel> defaultCategories = [
  CategoryModel(
    icon: MdiIcons.cart.codePoint,
    name: 'Groceries',
    color: Colors.primaries[0].value,
  ),
  CategoryModel(
    icon: MdiIcons.silverware.codePoint,
    name: 'Dining',
    color: Colors.primaries[1].value,
  ),
  CategoryModel(
    icon: MdiIcons.trainCar.codePoint,
    name: 'Transportation',
    color: Colors.primaries[2].value,
  ),
  CategoryModel(
    icon: MdiIcons.medicalCottonSwab.codePoint,
    name: 'Health & Medical',
    color: Colors.primaries[3].value,
  ),
  CategoryModel(
    icon: MdiIcons.gamepadSquare.codePoint,
    name: 'Entertainment',
    color: Colors.primaries[4].value,
  ),
  CategoryModel(
    icon: MdiIcons.airplane.codePoint,
    name: 'Travel',
    color: Colors.primaries[5].value,
  ),
  CategoryModel(
    icon: MdiIcons.school.codePoint,
    name: 'Education',
    color: Colors.primaries[6].value,
  ),
  CategoryModel(
    icon: MdiIcons.hanger.codePoint,
    name: 'Clothing',
    color: Colors.primaries[7].value,
  ),
  CategoryModel(
    icon: MdiIcons.gift.codePoint,
    name: 'Gifts',
    color: Colors.primaries[8].value,
  ),
  CategoryModel(
    icon: MdiIcons.cashSync.codePoint,
    name: 'Subscription',
    color: Colors.primaries[9].value,
  ),
  CategoryModel(
    icon: MdiIcons.paw.codePoint,
    name: 'Pet Care',
    color: Colors.primaries[10].value,
  ),
  CategoryModel(
    icon: MdiIcons.accountChild.codePoint,
    name: 'Childcare',
    color: Colors.primaries[11].value,
  )
];
