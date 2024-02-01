import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/widgets/playing_title.dart';
import 'package:flutter_cloud_music/pages/playing/controller.dart';
import 'package:get/get.dart';
import 'package:flutter_cloud_music/common/player/player.dart';

class PlayingPage extends GetView<PlayingController> {
  const PlayingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Material(
            color: Colors.transparent,
            child: Column(
              children: [
                Obx(() => PlayingTitle(song: context.curPlayRx.value)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
