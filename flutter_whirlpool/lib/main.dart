import 'package:flutter/material.dart';
import 'package:flutter_whirlpool/pages/main/view.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Smart Washing Machine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(235, 240, 243, 1),
      ),
      darkTheme: ThemeData(
        primaryColor: const Color.fromRGBO(32, 35, 41, 1),
      ),
      home: const MainPage(),
    );
  }
}
