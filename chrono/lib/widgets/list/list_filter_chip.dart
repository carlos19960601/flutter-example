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
