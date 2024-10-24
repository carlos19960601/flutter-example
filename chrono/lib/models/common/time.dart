import 'package:chrono/models/common/json.dart';

class Time extends JsonSerializable {
  final int hour;
  final int minute;
  final int second;

  const Time({this.hour = 0, this.minute = 0, this.second = 0});

  // named constructor
  Time.fromJson(Json json)
      : hour = json != null ? json['hours'] ?? 0 : 0,
        minute = json != null ? json['minutes'] ?? 0 : 0,
        second = json != null ? json['seconds'] ?? 0 : 0;

  Time.fromDateTime(DateTime dateTime)
      : hour = dateTime.hour,
        minute = dateTime.minute,
        second = dateTime.second;

  factory Time.now() => Time.fromDateTime(DateTime.now());

  @override
  Json? toJson() {
    return {
      'hours': hour,
      'minutes': minute,
      'seconds': second,
    };
  }
}
