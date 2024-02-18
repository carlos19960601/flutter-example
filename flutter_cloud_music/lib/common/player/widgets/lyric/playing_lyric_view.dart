import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/widgets/lyric/lyric_controller.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'dart:ui' as ui;

class PlayingLyricView extends StatelessWidget {
  PlayingLyricView({super.key, this.onTap});

  final controller = Get.put(LyricController());

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ProgressTrackingContainer(
      builder: _buildLyric,
      player: context.player,
    );
  }

  Widget _buildLyric(BuildContext context) {
    return GetBuilder<LyricController>(
      builder: (c) {
        const style = TextStyle(height: 2, fontSize: 16, color: Colors.white);
        return c.hasLyric
            ? LayoutBuilder(
                builder: (context, constraints) {
                  return ShaderMask(
                    shaderCallback: (rect) {
                      return ui.Gradient.linear(
                        Offset(rect.width / 2, 0),
                        Offset(rect.width / 2, constraints.maxHeight),
                        [
                          const Color(0x00FFFFFF),
                          style.color!,
                          style.color!,
                          const Color(0x00FFFFFF),
                        ],
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  c.message!,
                  style: style,
                ),
              );
      },
    );
  }
}
