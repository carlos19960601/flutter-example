import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:chrono/models/common/list_controller.dart';
import 'package:chrono/models/common/list_filter.dart';
import 'package:chrono/models/common/list_item.dart';
import 'package:chrono/widgets/list/list_filter_bar.dart';
import 'package:chrono/widgets/list/list_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomListView<ListItem> extends StatefulWidget {
  const CustomListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.listController,
    this.listFilters = const [],
  });

  final List<ListItem> items;
  final Widget Function(ListItem item)? itemBuilder;
  final List<ListFilterItem<ListItem>> listFilters;
  final ListController<ListItem> listController;

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState<Item extends ListItem>
    extends State<CustomListView<Item>> {
  late List<Item> currentList = List.from(widget.items);

  @override
  void initState() {
    super.initState();
    widget.listController.setAddItem(_handleAddItem);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListFilterBar(
          listFilters: widget.listFilters,
        ),
        Expanded(
          child: Stack(
            children: [
              SlidableAutoCloseBehavior(
                child: AnimatedReorderableListView(
                  items: currentList,
                  itemBuilder: (BuildContext context, int index) {
                    Item item = currentList[index];
                    Widget itemWidget = ListItemCard<Item>(
                      child: widget.itemBuilder != null
                          ? widget.itemBuilder!(item)
                          : const SizedBox(),
                    );
                    return itemWidget;
                  },
                  onReorder: _handleReorderItems,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _handleAddItem(Item item, {int index = -1}) async {
    if (index == -1) {
      index = widget.items.length;
    }
    widget.items.insert(index, item);
  }

  _handleReorderItems(int oldIndex, int newIndex) {}
}
