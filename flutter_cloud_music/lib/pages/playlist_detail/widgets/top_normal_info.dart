import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/controller.dart';
import 'package:get/get.dart';

class TopNormalInfo extends StatelessWidget {
  const TopNormalInfo({super.key, required this.controller});

  final PlaylistDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => const Row(
        children: [],
      ),
    );
  }
}
