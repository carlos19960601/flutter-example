import 'package:chrono/models/common/json.dart';
import 'package:chrono/models/common/list_item.dart';
import 'package:chrono/models/common/time_duration.dart';
import 'package:chrono/models/common/timer_state.dart';
import 'package:chrono/utils/id.dart';

class ClockTimer extends CustomizableListItem {
  TimeDuration _duration = TimeDuration.fromSeconds(5);
  DateTime _startTime = DateTime(0);
  TimerState _state = TimerState.stopped;

  late final int _id;

  ClockTimer(this._duration) : _id = getId();

  @override
  int get id => throw UnimplementedError();

  TimeDuration get duration => _duration;

  ClockTimer.from(ClockTimer timer) : _duration = timer._duration;

  @override
  Json? toJson() {
    return {
      "duration": 1,
    };
  }

  ClockTimer.fromJson(Json json) {
    if (json == null) {
      _id = getId();
      return;
    }
  }

  Future<void> start() async {
    _startTime = DateTime.now();
    
    _state = TimerState.running;
  }
}
