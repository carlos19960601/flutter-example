import 'package:blackhole/app.dart';
import 'package:blackhole/utils/storage.dart';
import 'package:flutter/material.dart';

void main() async {
  await GStorage.init();
  runApp(const BlackholeApp());
}
