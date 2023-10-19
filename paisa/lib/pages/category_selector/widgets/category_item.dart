import 'package:flutter/material.dart';
import 'package:paisa/model/category.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget(
      {super.key, required this.model, required this.onPress});

  final CategoryModel model;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Icon(
        IconData(model.icon ?? 0, fontFamily: 'MaterialIcons'),
        color: Color(model.color ?? Colors.brown.shade200.value),
      ),
      title: Text(model.name ?? ""),
      trailing: const Icon(Icons.delete),
    );
  }
}
