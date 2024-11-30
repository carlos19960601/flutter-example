import 'package:chrono/models/common/list_item.dart';
import 'package:chrono/utils/id.dart';
import 'package:flutter/material.dart';

abstract class ListFilterItem<ListItem> {
  bool isEnabled = true;

  bool get isActive;
  bool Function(ListItem) get filterFunction;
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

  int get id => _id;

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

abstract class FilterMultiSelect<Item extends ListItem>
    extends ListFilterItem<Item> {
  List<int> get selectedIndices;
  List<ListFilter<Item>> get selectedFilters;
  List<ListFilter<Item>> get filters;
  set selectedIndices(List<int> indices);

  @override
  bool Function(Item) get filterFunction {
    final currentFilters = filters;

    if (!currentFilters.any((filter) => filter.isSelected)) {
      return (Item item) => true;
    }

    return (Item item) => currentFilters
        .where((filter) => filter.isSelected)
        .any((filter) => filter.filterFunction(item));
  }
}

class DynamicListFilterMultiSelect<Item extends ListItem>
    extends FilterMultiSelect<Item> {
  // initializer list 在构造函数body之前执行，右值不能访问this
  DynamicListFilterMultiSelect(this.getLocalizedName, this.getFilters)
      : selectedIds =
            []; // https://dart.cn/language/constructors/#use-an-initializer-list

  final String Function(BuildContext) getLocalizedName;
  final List<ListFilter<Item>> Function() getFilters;
  List<int> selectedIds;

  @override
  String Function(BuildContext p1) get displayName =>
      throw UnimplementedError();

  @override
  bool get isActive => throw UnimplementedError();

  @override
  List<ListFilter<Item>> get selectedFilters => throw UnimplementedError();

  @override
  List<int> get selectedIndices => filters
      .where((filter) => filter.isSelected)
      .map((filter) => filters.indexOf(filter))
      .toList();

  @override
  set selectedIndices(List<int> indices) {
    final currentFilters = filters;
    selectedIds = indices.map((index) => currentFilters[index].id).toList();
  }

  @override
  List<ListFilter<Item>> get filters {
    final currentFilters = getFilters();
    for (var filter in currentFilters) {
      filter.isSelected = selectedIds.contains(filter.id);
    }

    return currentFilters;
  }
}
