import 'package:chrono/app.dart';
import 'package:chrono/utils/global.dart';
import 'package:flutter/material.dart';

void main() async {
  await Global.init();
  runApp(const App());
}
