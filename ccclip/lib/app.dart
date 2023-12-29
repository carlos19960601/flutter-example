import 'package:ccclip/pages/guide/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CcClipApp extends StatelessWidget {
  const CcClipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CC Clip',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF181818),
          primary: Colors.white,
          background: const Color(0xFF181818),
        ),
        useMaterial3: true,
      ),
      home: const GuidePage(),
    );
  }
}
