import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:pilipala/plugin/pl_player/models/data_source.dart';
import 'package:pilipala/plugin/pl_player/models/data_status.dart';
import 'package:pilipala/plugin/pl_player/models/play_status.dart';
import 'package:universal_platform/universal_platform.dart';

class PlPlayerController {
  Player? _videoPlayerController;
  VideoController? _videoController;
  // 添加一个私有静态变量来保存实例
  static PlPlayerController? _instance;

  final Rx<int> _playerCount = 0.obs;
  // 默认投稿视频格式
  static Rx<String> _videoType = 'archive'.obs;
  final Rx<BoxFit> _videoFit = Rx(BoxFit.contain);

  // ignore: prefer_final_fields
  PlaylistMode _looping = PlaylistMode.none;
  bool _autoPlay = false;

  final Rx<double> _playbackSpeed = 1.0.obs;
  final Rx<double> _currentVolume = 1.0.obs;
  final Rx<double> _currentBrightness = 0.0.obs;

  final Rx<bool> _mute = false.obs;
  final Rx<bool> _showControls = false.obs;
  final Rx<bool> _showVolumeStatus = false.obs;
  final Rx<bool> _showBrightnessStatus = false.obs;
  final Rx<bool> _doubleSpeedStatus = false.obs;
  final Rx<bool> _controlsLock = false.obs;
  final Rx<bool> _isFullScreen = false.obs;

  final Rx<String> _direction = 'horizontal'.obs;

  /// [playerStatus] has a [status] observable
  final PlPlayerStatus playerStatus = PlPlayerStatus();

  // 记录历史记录
  String _bvid = '';
  int _cid = 0;
  int _heartDuration = 0;
  bool _enableHeart = true;
  bool _isFirstTime = true;

  final Rx<Duration> _duration = Rx(Duration.zero);

  ///
  final PlPlayerDataStatus dataStatus = PlPlayerDataStatus();

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

  /// 视频比例
  Rx<BoxFit> get videoFit => _videoFit;

  VideoController? get videoController => _videoController;

  Future<Player> _createVideoController(
    DataSource dataSource,
    PlaylistMode looping,
    bool enableHA,
    double? width,
    double? height,
  ) async {
    Player player = _videoPlayerController ??
        Player(
          configuration: const PlayerConfiguration(bufferSize: 5 * 1024 * 1024),
        );

    var pp = player.platform as NativePlayer;
    // 音轨
    if (dataSource.audioSource != '' && dataSource.audioSource != null) {
      await pp.setProperty(
        'audio-files',
        UniversalPlatform.isWindows
            ? dataSource.audioSource!.replaceAll(';', '\\;')
            : dataSource.audioSource!.replaceAll(':', '\\:'),
      );
    }

    // 字幕
    if (dataSource.subFiles != '' && dataSource.subFiles != null) {
      await pp.setProperty(
        'sub-files',
        dataSource.subFiles!.replaceAll(':', '\\:'),
      );
      await pp.setProperty("subs-with-matching-audio", "no");
      await pp.setProperty("sub-forced-only", "yes");
      await pp.setProperty("blend-subtitles", "video");
    }

    _videoController = _videoController ??
        VideoController(
          player,
          configuration: VideoControllerConfiguration(
            enableHardwareAcceleration: enableHA,
          ),
        );

    player.setPlaylistMode(looping);

    player.open(
      Media(dataSource.videoSource!, httpHeaders: dataSource.httpHeaders),
      play: false,
    );
    // 音轨
    player.setAudioTrack(
      AudioTrack.uri(dataSource.audioSource!),
    );

    return player;
  }

  Future<void> setDataSource(
    DataSource dataSource, {
    bool autoplay = true,
    // 默认不循环
    PlaylistMode looping = PlaylistMode.none,
    // 初始化播放位置
    Duration seekTo = Duration.zero,
    // 初始化播放速度
    double speed = 1.0,
    // 硬件加速
    bool enableHA = true,
    double? width,
    double? height,
    Duration? duration,
    // 方向
    String? direction,
    // 记录历史记录
    String bvid = '',
    int cid = 0,
    // 历史记录开关
    bool enableHeart = true,
    // 是否首次加载
    bool isFirstTime = true,
  }) async {
    try {
      _autoPlay = autoplay;
      // 硬件加速
      bool enableHA = true;
      _looping = looping;
      // 初始化视频倍速
      _playbackSpeed.value = speed;
      // 初始化数据加载状态
      dataStatus.status.value = DataStatus.loading;
      // 初始化全屏方向
      _direction.value = direction ?? 'horizontal';
      _bvid = bvid;
      _cid = cid;
      _enableHeart = enableHeart;
      _isFirstTime = isFirstTime;

      // 配置Player 音轨、字幕等等
      _videoPlayerController = await _createVideoController(
          dataSource, _looping, enableHA, width, height);
      // 获取视频时长 00:00
      _duration.value = duration ?? _videoPlayerController!.state.duration;
      // 数据加载完成
      dataStatus.status.value = DataStatus.loaded;

      await _initializePlayer(seekTo: seekTo);
    } catch (err) {
      dataStatus.status.value = DataStatus.error;
      print('plPlayer err:  $err');
    }
  }

  // 开始播放
  Future _initializePlayer({
    Duration seekTo = Duration.zero,
  }) async {
    // 跳转播放
    // if (seekTo != Duration.zero) {
    //   await this.seekTo(seekTo);
    // }

    // 设置倍速
    // if (_playbackSpeed.value != 1.0) {
    //   await setPlaybackSpeed(_playbackSpeed.value);
    // }

    // if (_looping) {
    //   await setLooping(_looping);
    // }

    // 自动播放
    if (_autoPlay) {
      await play();
    }
  }

  /// 播放视频
  Future<void> play({bool repeat = false, bool hideControls = true}) async {
    // repeat为true，将从头播放
    // if (repeat) {
    //   await seekTo(Duration.zero);
    // }
    await _videoPlayerController?.play();

    // await getCurrentVolume();
    // await getCurrentBrightness();

    playerStatus.status.value = PlayerStatus.playing;
    // screenManager.setOverlays(false);

    // 播放时自动隐藏控制条
    // if (hideControls) {
    //   _hideTaskControls();
    // }
  }
}
