import 'dart:convert';

import 'package:flutter_cloud_music/common/utils/time.dart';

class LyricEntry {
  LyricEntry(this.line, this.position, this.duration)
      : timeStamp = getTimeStamp(position);

  static RegExp pattern = RegExp(r"\[\d{2}:\d{2}.\d{2,3}]");

  static int _stamp2int(final String stamp) {
    final int indexOfColon = stamp.indexOf(":");
    final int indexOfPoint = stamp.indexOf(".");

    final int minute = int.parse(stamp.substring(1, indexOfColon));
    final int second =
        int.parse(stamp.substring(indexOfColon + 1, indexOfPoint));
    int millisecond;
    if (stamp.length - indexOfPoint == 2) {
      millisecond =
          int.parse(stamp.substring(indexOfPoint + 1, stamp.length)) * 10;
    } else {
      millisecond =
          int.parse(stamp.substring(indexOfPoint + 1, stamp.length - 1));
    }
    return (((minute * 60) + second) * 1000) + millisecond;
  }

  final String timeStamp;
  final String? line;

  final int position;

  ///the duration of this line
  final int duration;

  ///build from a .lrc file line .such as: [11:44.100] what makes your beautiful
  static void inflate(String line, Map<int, String> map) {
    //TODO lyric info
    if (line.startsWith("[ti:")) {
    } else if (line.startsWith("[ar:")) {
    } else if (line.startsWith("[al:")) {
    } else if (line.startsWith("[au:")) {
    } else if (line.startsWith("[by:")) {
    } else {
      final stamps = pattern.allMatches(line);
      final content = line.split(pattern).last;
      for (final stamp in stamps) {
        final int timeStamp = _stamp2int(stamp.group(0)!);
        map[timeStamp] = content;
      }
    }
  }
}

class LyricContent {
  LyricContent.from(String text) {
    final List<String> lines = _kLineSplitter.convert(text);
    final Map map = <int, String>{};
    for (final line in lines) {
      LyricEntry.inflate(line, map as Map<int, String>);
    }

    final List<int> keys = map.keys.toList() as List<int>..sort();
    for (var i = 0; i < keys.length; i++) {
      final key = keys[i];
      _durations.add(key);
      int duration = _kDefaultLineDuration;
      if (i + 1 < keys.length) {
        duration = keys[i + 1] - key;
      }
      _lyricEntries.add(LyricEntry(map[key], key, duration));
    }
  }

  int _getTimeStamp(int index) {
    return _durations[index];
  }

  ///splitter lyric content to line
  static const LineSplitter _kLineSplitter = LineSplitter();

  //默认歌词持续时间
  static const int _kDefaultLineDuration = 5 * 1000;

  final List<int> _durations = [];
  final List<LyricEntry> _lyricEntries = [];

  int get size => _durations.length;
}
