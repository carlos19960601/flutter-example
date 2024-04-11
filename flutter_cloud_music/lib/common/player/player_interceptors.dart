import 'dart:developer';

import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/http/api.dart';
import 'package:flutter_cloud_music/http/music.dart';
import 'package:music_player/music_player.dart';

class PlayerInterceptors {
  // 获取播放地址
  static Future<String> playUriInterceptor(
      String? mediaId, String? fallbackUri) async {
    final ApiResponse<String> apiResponse =
        await MusicHttp.getPlayUrl(int.parse(mediaId!));

    if (!apiResponse.status) {
      return fallbackUri ?? '';
    }

    String result = apiResponse.data!;

    log('url = $result');
    return result.replaceFirst("http://", "https://");
  }

  // static Future<Uint8List> loadImageInterceptor(MusicMetadata metadata) async {
  // }
}

class QuietPlayQueueInterceptor extends PlayQueueInterceptor {
  @override
  Future<List<MusicMetadata>> fetchMoreMusic(
      BackgroundPlayQueue queue, PlayMode playMode) async {
    if (queue.queueId == kFmPlayQueueId) {
      final ApiResponse apiResponse = await MusicHttp.getFmMusics();
      return apiResponse.data.toMetadataList() ?? List.empty();
    }
    return super.fetchMoreMusic(queue, playMode);
  }
}
