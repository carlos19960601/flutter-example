import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/found/controller.dart';
import 'package:flutter_cloud_music/pages/found/widgets/found_appbar.dart';
import 'package:get/get.dart';

class FoundPage extends StatelessWidget {
  FoundPage({super.key});

  final FoundController controller = Get.put(FoundController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoundAppbar(),
      body: const Stack(
        children: [],
      ),
    );
  }
}
