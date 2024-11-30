import 'package:chrono/models/common/json.dart';

extension DurationUtils on Duration {
  TimeDuration toTimeDuration() {
    return TimeDuration(
      hours: inHours,
      minutes: inMinutes % 60,
      seconds: inSeconds % 60,
      milliseconds: inMilliseconds % 1000,
    );
  }
}

class TimeDuration extends JsonSerializable {
  TimeDuration({
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.milliseconds = 0,
  });

  final int hours;
  final int minutes;
  final int seconds;
  final int milliseconds;

  int get inSeconds => hours * 3600 + minutes * 60 + seconds;

  TimeDuration.fromSeconds(int seconds)
      : hours = (seconds / 3600).floor(),
        minutes = ((seconds % 3600) / 60).floor(),
        seconds = (seconds % 60),
        milliseconds = 0;

  @override
  Json? toJson() => {
        "hours": hours,
        "minutes": minutes,
        "seconds": seconds,
        "milliseconds": milliseconds,
      };

  TimeDuration.fromJson(Json json)
      : hours = json != null ? json["hours"] ?? 0 : 0,
        minutes = json != null ? json["minutes"] ?? 0 : 0,
        seconds = json != null ? json["seconds"] ?? 0 : 0,
        milliseconds = json != null ? json["milliseconds"] ?? 0 : 0;
}
