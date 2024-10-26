import 'package:chrono/core/app_extension.dart';
import 'package:chrono/models/common/list_filter.dart';
import 'package:chrono/models/common/list_item.dart';
import 'package:chrono/widgets/card_container.dart';
import 'package:flutter/material.dart';

Widget getListFilterChip<Item extends ListItem>(ListFilterItem<Item> item) {
  if (item.runtimeType == ListFilter<Item>) {
    return ListFilterChip(
      listFilter: item as ListFilter<Item>,
    );
  }

  if (item.runtimeType == ListFilterSelect<Item>) {
    return ListFilterSelectChip<Item>(
      listFilter: item as ListFilterSelect<Item>,
    );
  }

  if (item.runtimeType == DynamicListFilterMultiSelect<Item>) {}

  return const Text("Unknown Filter Type");
}

class ListFilterChip<Item extends ListItem> extends StatelessWidget {
  const ListFilterChip({
    super.key,
    required this.listFilter,
  });

  final ListFilter<Item> listFilter;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          listFilter.displayName(context),
          style: context.headlineSmall?.copyWith(
            color:
                listFilter.isSelected ? context.onPrimary : context.onSurface,
          ),
        ),
      ),
    );
  }
}

class ListFilterSelectChip<Item extends ListItem> extends StatelessWidget {
  const ListFilterSelectChip({
    super.key,
    required this.listFilter,
  });

  final FilterSelect<Item> listFilter;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, bottom: 8.0, left: 16.0, right: 2.0),
            child: Text(
              listFilter.displayName(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2.0, right: 8.0),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: context.onPrimary.withOpacity(0.6),
            ),
          )
        ],
      ),
    );
  }
}
