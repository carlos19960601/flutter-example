import 'package:flutter/material.dart';
import 'package:flutter_wallet_ui/pages/home/view.dart';
import 'package:flutter_wallet_ui/routes/app_pages.dart';
import 'package:get/get.dart';

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
