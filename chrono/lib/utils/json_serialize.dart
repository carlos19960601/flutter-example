import 'dart:convert';

import 'package:chrono/developer/logger.dart';
import 'package:chrono/models/alarm/alarm.dart';
import 'package:chrono/models/common/json.dart';

final fromJsonFactories = <Type, Function>{
  Alarm: (Json json) => Alarm.fromJson(json),
};

List<T> listFromString<T extends JsonSerializable>(String encodedItems) {
  if (!fromJsonFactories.containsKey(T)) {
    throw Exception(
        "No fromJson factory for type '$T'. Please add one in the file 'utils/json_serialize.dart'");
  }

  try {
    List<dynamic> rawList = jsonDecode(encodedItems) as List<dynamic>;
    Function fromJson = fromJsonFactories[T]!;
    List<T> list = rawList.map<T>((json) => fromJson(json)).toList();
    return list;
  } catch (e) {
    logger.e("Error decoding string: ${e.toString()}");
    rethrow;
  }
}

String listToString<T extends JsonSerializable>(List<T> items) =>
    jsonEncode(items);
