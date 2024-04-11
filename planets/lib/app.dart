import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planets/pages/home/view.dart';
import 'package:planets/routes/app_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Panets: Explore the Solar System',
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      getPages: AppPages.routes,
      home: const HomePage(),
    );
  }
}
