import 'package:chrono/models/common/list_filter.dart';
import 'package:chrono/models/common/list_item.dart';
import 'package:chrono/widgets/list/list_filter_chip.dart';
import 'package:flutter/material.dart';

class ListFilterBar<Item extends ListItem> extends StatelessWidget {
  const ListFilterBar({super.key, required this.listFilters});

  final List<ListFilterItem<Item>> listFilters;

  @override
  Widget build(BuildContext context) {
    List<Widget> getFilterChips() {
      List<Widget> widgets = [];
      widgets.addAll(listFilters.map((filter) => getListFilterChip(filter)));
      return widgets;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: getFilterChips(),
        ),
      ),
    );
  }

  List<Widget> getFilterChips() {
    List<Widget> widgets = [];

    widgets.addAll(listFilters.map((filter) => getListFilterChip(filter)));
    return widgets;
  }
}
