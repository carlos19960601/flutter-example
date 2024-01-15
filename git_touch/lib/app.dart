import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_touch/pages/home/view.dart';
import 'package:git_touch/routes/app_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      getPages: AppPages.routes,
      home: const HomePage(),
    );
  }
}
