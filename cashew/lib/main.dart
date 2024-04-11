import 'package:cashew/app.dart';
import 'package:cashew/utils/storage.dart';
import 'package:flutter/material.dart';

void main() async {
  await GStorage.init();
  runApp(const CashewApp());
}
