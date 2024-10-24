import 'package:chrono/models/common/json.dart';
import 'package:chrono/models/common/list_item.dart';
import 'package:chrono/utils/id.dart';
import 'package:flutter/material.dart';

class Tag extends ListItem {
  final int _id;
  String name;
  String description;
  Color color;

  Tag(
    this.name, {
    this.description = "",
    this.color = Colors.blue,
  }) : _id = getId();

  @override
  int get id => _id;

  @override
  Json? toJson() => {
        'id': _id,
        'name': name,
        'description': description,
        'color': color.value,
      };
}
