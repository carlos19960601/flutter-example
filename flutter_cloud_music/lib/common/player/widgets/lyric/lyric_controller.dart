import 'dart:developer';

import 'package:flutter_cloud_music/common/player/lyric.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/models/song_model.dart';
import 'package:get/get.dart';

class LyricController extends GetxController {
  LyricContent? _lyricContent;
  LyricContent? get lyric => _lyricContent;
  bool get hasLyric => lyric != null && lyric!.size > 0;

  ///没有歌词时的提示
  String? get message => _message;
  final String _message = '暂无歌词';

  Song? _music;

  @override
  void onInit() {
    super.onInit();
    _shouldLoadLyric(PlayerService.to.curPlay.value);
  }

  void _shouldLoadLyric(Song? music) {
    if (_music == music) {
      return;
    }
    _music = music;
    if (music == null) {
      _setLyric();
      return;
    }
  }

  void _setLyric({String? lyric, String? message}) {}
}
