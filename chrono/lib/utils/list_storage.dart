import 'dart:io';

import 'package:chrono/core/app_path.dart';
import 'package:chrono/developer/logger.dart';
import 'package:chrono/models/common/json.dart';
import 'package:chrono/utils/json_serialize.dart';
import 'package:path/path.dart' as path;

Future<void> saveList<T extends JsonSerializable>(
    String key, List<T> list) async {
  await saveTextFile(key, listToString(list));
}

List<T> loadListSync<T extends JsonSerializable>(String key) {
  try {
    return listFromString<T>(loadTextFileSync(key));
  } catch (e) {
    logger.e("Error loading list ($key): $e");
    return [];
  }
}

String loadTextFileSync<T extends JsonSerializable>(String key) {
  File file = File(path.join(getAppDataDirectoryPathSync(), '$key.txt'));

  try {
    return file.readAsStringSync();
  } catch (error) {
    throw Exception("Failed to load list from file '$key': $error");
  }
}

Future<void> saveTextFile(String key, String content) async {
  String appDataDirectory = getAppDataDirectoryPathSync();
  File file = File(path.join(appDataDirectory, "$key.txt"));
  if (!file.existsSync()) {
    file.createSync();
  }

  await file.writeAsString(content, mode: FileMode.writeOnly);
}
