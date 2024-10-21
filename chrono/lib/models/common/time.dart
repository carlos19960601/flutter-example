import 'package:chrono/models/common/json.dart';

class Time extends JsonSerializable {
  final int hour;
  final int minute;
  final int second;

  const Time({this.hour = 0, this.minute = 0, this.second = 0});

  @override
  Json? toJson() {
    return {
      'hours': hour,
      'minutes': minute,
      'seconds': second,
    };
  }
}
