import 'package:chrono/models/common/list_filter.dart';
import 'package:chrono/models/common/list_item.dart';
import 'package:chrono/widgets/list/custom_list_view.dart';
import 'package:flutter/material.dart';

class PersistentListView<Item extends ListItem> extends StatefulWidget {
  const PersistentListView({
    super.key,
    required this.saveTag,
    required this.itemBuilder,
    this.listFilters = const [],
  });

  final String saveTag;
  final List<ListFilterItem<Item>> listFilters;
  final Widget Function(Item item) itemBuilder;

  @override
  State<PersistentListView> createState() => _PersistentListViewState();
}

class _PersistentListViewState<Item extends ListItem>
    extends State<PersistentListView> {
  final List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    if (widget.saveTag.isNotEmpty) {}
  }

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      items: _items,
      itemBuilder: widget.itemBuilder,
      listFilters: widget.listFilters,
    );
  }
}
