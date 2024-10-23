import 'package:chrono/models/common/list_item.dart';
import 'package:chrono/utils/id.dart';
import 'package:flutter/material.dart';

abstract class ListFilterItem<Item extends ListItem> {
  bool isEnabled = true;

  bool get isActive;
  bool Function(Item) get filterFunction;
  String Function(BuildContext) get displayName;
}

class ListFilter<Item extends ListItem> extends ListFilterItem<Item> {
  ListFilter(this.getLocalizedName, bool Function(Item) filterFunction,
      {int? id})
      : _id = id ?? getId(),
        _filterFunction = filterFunction;

  final int _id;
  bool isSelected = false;
  final bool Function(Item) _filterFunction;
  final String Function(BuildContext) getLocalizedName;

  @override
  bool get isActive => isSelected;

  @override
  bool Function(Item) get filterFunction {
    return _filterFunction;
  }

  @override
  String Function(BuildContext) get displayName => getLocalizedName;
}

abstract class FilterSelect<Item extends ListItem>
    extends ListFilterItem<Item> {
  int get selectedIndex;
  set selectedIndex(int index);

  ListFilter<Item> get selectedFilter;
  List<ListFilter<Item>> get filters;

  @override
  bool Function(Item) get filterFunction {
    try {
      return selectedFilter.filterFunction;
    } catch (e) {
      return (Item item) => true;
    }
  }
}

ListFilter<Item> defaultFilter<Item extends ListItem>() {
  return ListFilter<Item>((constext) => "", (item) => true, id: -1);
}

class ListFilterSelect<Item extends ListItem> extends FilterSelect<Item> {
  final String Function(BuildContext) getLocalizedName;

  ListFilterSelect(this.getLocalizedName, this.filters) {
    filters.insert(0, defaultFilter<Item>());
    if (filters.isNotEmpty) {
      filters[0].isSelected = true;
    }
  }

  @override
  int get selectedIndex {
    return filters.indexWhere((filter) => filter.isSelected);
  }

  @override
  String Function(BuildContext) get displayName => getLocalizedName;

  @override
  bool get isActive => throw UnimplementedError();

  @override
  List<ListFilter<Item>> filters;

  @override
  set selectedIndex(int index) {}

  @override
  ListFilter<Item> get selectedFilter {
    return filters.firstWhere((filter) => filter.isSelected);
  }
}
