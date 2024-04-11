import 'package:flutter/material.dart';
import 'package:paisa/app.dart';
import 'package:paisa/utils/storage.dart';

void main() async {
  await GStorage.init();
  runApp(const PaisaApp());
}
