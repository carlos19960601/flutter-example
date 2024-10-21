import 'package:chrono/models/common/list_filter.dart';
import 'package:chrono/models/common/list_item.dart';
import 'package:chrono/widgets/list/list_filter_bar.dart';
import 'package:flutter/material.dart';

class CustomListView<Item extends ListItem> extends StatefulWidget {
  const CustomListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.listFilters = const [],
  });

  final List<Item> items;
  final Widget Function(Item) itemBuilder;
  final List<ListFilterItem<Item>> listFilters;

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListFilterBar(
          listFilters: widget.listFilters,
        ),
        const Expanded(child: Stack())
      ],
    );
  }
}
