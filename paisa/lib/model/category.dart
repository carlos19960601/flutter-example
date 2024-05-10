import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  double? budget;
  @HiveField(1)
  int? color;
  @HiveField(2)
  String? description;
  @HiveField(3)
  int? icon;
  @HiveField(4)
  bool? isBudget;
  @HiveField(5)
  bool? isDefault;
  @HiveField(6)
  String? name;

  CategoryModel({
    required this.icon,
    required this.name,
    required this.color,
    this.isDefault = false,
    this.description,
    this.isBudget = false,
    this.budget = -1,
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
}

final List<CategoryModel> defaultCategoriesData = [
  CategoryModel(
    icon: Icons.shopping_cart.codePoint,
    name: "Groceries",
    color: Colors.primaries[0].value,
  ),
  CategoryModel(
    icon: Icons.dining.codePoint,
    name: "Dining",
    color: Colors.primaries[1].value,
  ),
  CategoryModel(
    icon: Icons.train.codePoint,
    name: "Transportation",
    color: Colors.primaries[2].value,
  ),
  CategoryModel(
    icon: Icons.medical_services.codePoint,
    name: 'Health & Medical',
    color: Colors.primaries[3].value,
  ),
  CategoryModel(
    icon: Icons.gamepad.codePoint,
    name: 'Entertainment',
    color: Colors.primaries[4].value,
  ),
  CategoryModel(
    icon: Icons.airlines.codePoint,
    name: 'Travel',
    color: Colors.primaries[5].value,
  ),
  CategoryModel(
    icon: Icons.school.codePoint,
    name: 'Education',
    color: Colors.primaries[6].value,
  ),
  CategoryModel(
    icon: Icons.checkroom.codePoint,
    name: 'Clothing',
    color: Colors.primaries[7].value,
  ),
  CategoryModel(
    icon: Icons.card_giftcard.codePoint,
    name: 'Gifts',
    color: Colors.primaries[8].value,
  ),
  CategoryModel(
    icon: Icons.subscriptions_outlined.codePoint,
    name: 'Subscription',
    color: Colors.primaries[9].value,
  ),
  CategoryModel(
    icon: Icons.pets.codePoint,
    name: 'Pet Care',
    color: Colors.primaries[10].value,
  ),
  CategoryModel(
    icon: Icons.child_care.codePoint,
    name: 'Childcare',
    color: Colors.primaries[11].value,
  )
];
