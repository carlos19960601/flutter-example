import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class PlPlayerController {
  Player? _videoPlayerController;
  VideoController? _videoController;
  // 添加一个私有静态变量来保存实例
  static PlPlayerController? _instance;

  final Rx<int> _playerCount = 0.obs;
  // 默认投稿视频格式
  static Rx<String> _videoType = 'archive'.obs;
  PlPlayerController._() {}

  static PlPlayerController getInstance({
    String videoType = 'archive',
    List<BoxFit> fits = const [
      BoxFit.contain,
      BoxFit.cover,
      BoxFit.fill,
      BoxFit.fitHeight,
      BoxFit.fitWidth,
      BoxFit.scaleDown
    ],
  }) {
    // 如果实例尚未创建，则创建一个新实例
    _instance ??= PlPlayerController._();
    _instance!._playerCount.value += 1;
    _videoType.value = videoType;
    return _instance!;
  }

  VideoController? get videoController => _videoController;

  Future<Player> _createVideoController(
    bool enableHA,
  ) async {
    Player player = _videoPlayerController ??
        Player(
          configuration: const PlayerConfiguration(bufferSize: 5 * 1024 * 1024),
        );

    _videoController = _videoController ??
        VideoController(player,
            configuration: VideoControllerConfiguration(
              enableHardwareAcceleration: enableHA,
            ));
    return player;
  }

  Future<void> setDataSource() async {
    // 硬件加速
    bool enableHA = true;
    _videoPlayerController = await _createVideoController(enableHA);
  }
}
