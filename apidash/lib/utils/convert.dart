import 'package:apidash/models/name_value_model.dart';

Map<String, String>? rowsToMap(List<NameValueModel>? kvRows,
    {bool isHeader = false}) {
  if (kvRows == null) {
    return null;
  }
  Map<String, String> finalMap = {};
  for (var row in kvRows) {
    if (row.name?.trim() != "") {
      String key = row.name!;
      if (isHeader) {
        key = key.toLowerCase();
      }
      finalMap[key] = row.value.toString();
    }
  }
  return finalMap;
}
