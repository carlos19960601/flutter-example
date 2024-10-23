import 'package:chrono/localization/i18n_keyword.dart';
import 'package:chrono/models/alarm/alarm.dart';
import 'package:chrono/models/common/list_filter.dart';
import 'package:get/get.dart';

final List<ListFilterItem<Alarm>> alarmListFilters = [
  ListFilterSelect(
    (context) => I18nKeyword.dateFilterGroup.tr,
    [
      ListFilter((context) => I18nKeyword.todayFilter.tr, (alarm) => true),
      ListFilter((context) => I18nKeyword.tomorrowFilter.tr, (alarm) => true),
    ],
  ),
];
