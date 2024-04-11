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
