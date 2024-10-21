import 'package:chrono/models/common/json.dart';

abstract class AlarmSchedule extends JsonSerializable {
  DateTime? get currentScheduleDateTime;

  bool get isDisabled;
  bool get isFinished;
}
