import 'package:chrono/models/common/json.dart';
import 'package:chrono/models/common/list_item.dart';
import 'package:chrono/utils/id.dart';

class City extends ListItem {
  late String _name = "Unknown";
  late String _country = "Unknown";
  late String _timezone = 'America/Detroit';
  late int _id;

  City(this._name, this._country, this._timezone) : _id = getId();

  String get name => _name;
  String get country => _country;
  String get timezone => _timezone;

  @override
  int get id => _id;

  City.fromJson(Json json) {
    if (json == null) {
      _id = getId();
      return;
    }
    _name = json['name'] ?? 'Unknown';
    _country = json['country'] ?? 'Unknown';
    _timezone = json['timezone'] ?? 'America/Detroit';
    _id = json['id'] ?? getId();
  }

  @override
  Json? toJson() => {
        'name': name,
        'country': country,
        'timezone': timezone,
        'id': id,
      };
}
