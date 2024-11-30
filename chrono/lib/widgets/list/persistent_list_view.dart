import 'package:chrono/models/common/list_controller.dart';
import 'package:chrono/models/common/list_filter.dart';
import 'package:chrono/models/common/list_item.dart';
import 'package:chrono/utils/list_storage.dart';
import 'package:chrono/widgets/list/custom_list_view.dart';
import 'package:flutter/material.dart';

class PersistentListController<T> {
  final ListController<T> _listController = ListController<T>();

  PersistentListController();

  ListController<T> get listController => _listController;

  void addItem(T item) {
    _listController.addItem(item);
  }

  List<T> getItems() {
    return _listController.getItems();
  }
}

class PersistentListView<Item extends ListItem> extends StatefulWidget {
  const PersistentListView({
    super.key,
    required this.saveTag,
    required this.itemBuilder,
    required this.listController,
    this.listFilters = const [],
  });

  final String saveTag;
  final List<ListFilterItem<Item>> listFilters;
  final Widget Function(ListItem item) itemBuilder;
  final PersistentListController<Item> listController;

  @override
  State<PersistentListView> createState() => _PersistentListViewState();
}

class _PersistentListViewState<Item extends ListItem>
    extends State<PersistentListView<Item>> {
  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    if (widget.saveTag.isNotEmpty) {
      _items = loadListSync<Item>(widget.saveTag);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      items: _items,
      itemBuilder: widget.itemBuilder,
      listFilters: widget.listFilters,
      listController: widget.listController.listController,
    );
  }

  void _saveItems() async {
    if (widget.saveTag.isNotEmpty) {
      await saveList<Item>(widget.saveTag, _items);
    }
  }

  void reloadItems() {
    List<Item> newList = loadListSync(widget.saveTag);
  }
}
