import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';

extension QuitPlayerExt on BuildContext {
  PlayerService get playerService {
    try {
      return PlayerService.to;
    } catch (e, stacktrace) {
      log(stacktrace.toString());
      rethrow;
    }
  }
}
