import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/mine/controller.dart';
import 'package:flutter_cloud_music/pages/mine/widgets/bar.dart';
import 'package:get/get.dart';

class MinePage extends StatelessWidget {
  MinePage({super.key});
  final MineController controller = Get.put(MineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          MineViewBar(),
        ],
      ),
    );
  }
}
