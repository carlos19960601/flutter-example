import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/print_debug_output.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(lineLength: 20),
  output: DebugPrintConsoleOutput(),
);

void notImplemented(BuildContext context) {
  toast('待开发...');
}
