import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/models/song_model.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';

const String kFmPlayQueueId = "personal_fm";

extension QuitPlayerExt on BuildContext {
  PlayerService get playerService {
    try {
      return PlayerService.to;
    } catch (e, stacktrace) {
      log(stacktrace.toString());
      rethrow;
    }
  }

  MusicPlayer get player {
    try {
      return PlayerService.to.player;
    } catch (e, stacktrace) {
      log(stacktrace.toString());
      rethrow;
    }
  }

  Rxn<Song> get curPlayRx {
    try {
      return PlayerService.to.curPlay;
    } catch (e, stacktrace) {
      log(stacktrace.toString());
      rethrow;
    }
  }

  Rx<PlayMode> get playModelRx {
    try {
      return PlayerService.to.playMode;
    } catch (e, stacktrace) {
      log(stacktrace.toString());
      rethrow;
    }
  }
}
