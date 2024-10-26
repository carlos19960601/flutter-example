import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:chrono/models/common/list_filter.dart';
import 'package:chrono/models/common/list_item.dart';
import 'package:chrono/widgets/list/list_filter_bar.dart';
import 'package:chrono/widgets/list/list_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

class _CustomListViewState<Item extends ListItem>
    extends State<CustomListView> {
  late List<Item> currentList = List.from(widget.items);
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
                      child: widget.itemBuilder(item),
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

  _handleReorderItems(int oldIndex, int newIndex) {}
}
