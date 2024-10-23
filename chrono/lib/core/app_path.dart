import 'dart:io';

import 'package:chrono/developer/logger.dart';
import "package:path/path.dart" as path;
import 'package:path_provider/path_provider.dart';

const _appDataDirectory = "Clock";

String _appDataDirectoryPath = "";

Future<void> initializeAppDataDirectory() async {
  _appDataDirectoryPath = await getAppDataDirectoryPath();
  logger.i("appDataDirectoryPath: $_appDataDirectoryPath");

  if (!await Directory(_appDataDirectoryPath).exists()) {
    await Directory(_appDataDirectoryPath).create();
  }
}

String getAppDataDirectoryPathSync() {
  if (_appDataDirectoryPath.isEmpty) {
    throw Exception(
        "App data directory path is not initialized. Call 'initializeAppDataDirectory()' first.");
  }
  return _appDataDirectoryPath;
}

Future<String> getAppDataDirectoryPath() async {
  return path.join(
      (await getApplicationDocumentsDirectory()).path, _appDataDirectory);
}
