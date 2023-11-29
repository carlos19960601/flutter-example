import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuietApp extends StatefulWidget {
  const QuietApp({super.key});

  @override
  State<QuietApp> createState() => _QuietAppState();
}

class _QuietAppState extends State<QuietApp> {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Quiet',
      home: MainPage(),
    );
  }
}
