import 'package:chrono/models/alarm/alarm.dart';
import 'package:chrono/models/alarm/alarm_list_filters.dart';
import 'package:chrono/models/common/list_filter.dart';
import 'package:chrono/pages/alarm/widgets/alarm_card.dart';
import 'package:chrono/widgets/fab.dart';
import 'package:chrono/widgets/list/persistent_list_view.dart';
import 'package:flutter/material.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PersistentListView<Alarm>(
          saveTag: "alarms",
          itemBuilder: (Alarm alarm) => AlarmCard(alarm: alarm),
          listFilters: _getListFilterItems(),
        ),
        const FAB(),
      ],
    );
  }

  List<ListFilterItem<Alarm>> _getListFilterItems() {
    List<ListFilterItem<Alarm>> listFilterItems = [...alarmListFilters];

    return listFilterItems;
  }
}
