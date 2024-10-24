import 'package:chrono/localization/i18n_keyword.dart';
import 'package:chrono/models/alarm/alarm.dart';
import 'package:chrono/models/common/list_filter.dart';
import 'package:chrono/models/common/tag.dart';
import 'package:chrono/utils/list_storage.dart';
import 'package:get/get.dart';

final List<ListFilterItem<Alarm>> alarmListFilters = [
  ListFilterSelect(
    (context) => I18nKeyword.dateFilterGroup.tr,
    [
      ListFilter((context) => I18nKeyword.todayFilter.tr, (alarm) => true),
      ListFilter((context) => I18nKeyword.tomorrowFilter.tr, (alarm) => true),
    ],
  ),
  ListFilterSelect(
    (context) => I18nKeyword.stateFilterGroup.tr,
    [
      ListFilter((context) => I18nKeyword.activeFilter.tr, (alarm) => true),
      ListFilter((context) => I18nKeyword.snoozedFilter.tr, (alarm) => true),
      ListFilter((context) => I18nKeyword.disabledFilter.tr, (alarm) => true),
      ListFilter((context) => I18nKeyword.completedFilter.tr, (alarm) => true),
    ],
  ),
  DynamicListFilterMultiSelect((context) => I18nKeyword.tagsSetting, () {
    final tags = loadListSync<Tag>("tags");
    return tags
        .map(
          (tag) => ListFilter<Alarm>(
            (context) => tag.name,
            (alarm) => alarm.tags.any((element) => element.id == tag.id),
            id: tag.id,
          ),
        )
        .toList();
  })
];
