import 'package:chrono/models/alarm/schedules/alarm_schedule.dart';
import 'package:chrono/models/common/json.dart';
import 'package:chrono/models/common/list_item.dart';
import 'package:chrono/models/common/time.dart';

class Alarm extends CustomizableListItem {
  late Time _time;
  DateTime? _snoozeTime;
  final int _snoozeCount = 0;

  late List<AlarmSchedule> _schedules;

  DateTime? get snoozeTime => _snoozeTime;
  bool get isSnoozed => _snoozeTime != null;

  bool get canBeDisabled => !isSnoozed;

  @override
  int get id => throw UnimplementedError();

  @override
  Json? toJson() {
    throw UnimplementedError();
  }
}
