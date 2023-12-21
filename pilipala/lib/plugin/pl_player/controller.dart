import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:pilipala/plugin/pl_player/models/data_source.dart';
import 'package:pilipala/plugin/pl_player/models/data_status.dart';
import 'package:pilipala/plugin/pl_player/models/fullscreen_mode.dart';
import 'package:pilipala/plugin/pl_player/models/play_repeat.dart';
import 'package:pilipala/plugin/pl_player/models/play_status.dart';
import 'package:pilipala/plugin/pl_player/utils/fullscreen.dart';
import 'package:pilipala/plugin/pl_player/view.dart';
import 'package:pilipala/utils/storage.dart';
import 'package:status_bar_control/status_bar_control.dart';
import 'package:universal_platform/universal_platform.dart';

Box videoStorage = GStorage.video;
Box setting = GStorage.setting;
Box localCache = GStorage.localCache;

class PlPlayerController {
  Player? _videoPlayerController;
  VideoController? _videoController;
  // 添加一个私有静态变量来保存实例
  static PlPlayerController? _instance;

  final Rx<int> _playerCount = 0.obs;
  // 默认投稿视频格式
  static Rx<String> _videoType = 'archive'.obs;

  final Rx<BoxFit> _videoFit = Rx(BoxFit.contain);
  final Rx<String> _videoFitDesc = Rx('包含');

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

  final bool _listenersInitialized = false;

  // 播放顺序相关
  PlayRepeat playRepeat = PlayRepeat.pause;

  // 播放位置
  // ignore: prefer_final_fields
  Rx<bool> _isSliderMoving = false.obs;
  final Rx<Duration> _position = Rx(Duration.zero);
  final Rx<Duration> _sliderPosition = Rx(Duration.zero);

  final Rx<Duration> _buffered = Rx(Duration.zero);

  Rx<int> get playerCount => _playerCount;

  ///
  Rx<String> get videoType => _videoType;

  /// 视频当前播放位置
  Rx<Duration> get position => _position;
  Rx<Duration> get sliderPosition => _sliderPosition;
  Rx<bool> get isSliderMoving => _isSliderMoving;

  // 视频缓冲
  Rx<Duration> get buffered => _buffered;

  /// 全屏状态
  Rx<bool> get isFullScreen => _isFullScreen;

  /// [playerStatus] has a [status] observable
  final PlPlayerStatus playerStatus = PlPlayerStatus();

  /// [videoPlayerController] instace of Player
  Player? get videoPlayerController => _videoPlayerController;

  /// 屏幕锁 为true时，关闭控制栏
  Rx<bool> get controlsLock => _controlsLock;

  /// 是否展示控制条及监听
  Rx<bool> get showControls => _showControls;

  /// 视频播放速度
  double get playbackSpeed => _playbackSpeed.value;

  /// 视频时长
  Rx<Duration> get duration => _duration;

  /// 视频比例
  Rx<BoxFit> get videoFit => _videoFit;
  Rx<String> get videoFitDEsc => _videoFitDesc;

  /// 全屏方向
  Rx<String> get direction => _direction;

  // 记录历史记录
  String _bvid = '';
  int _cid = 0;
  int _heartDuration = 0;
  bool _enableHeart = true;
  bool _isFirstTime = true;

  final Rx<Duration> _duration = Rx(Duration.zero);

  /// 弹幕开关
  Rx<bool> isOpenDanmu = false.obs;
  // 弹幕相关配置
  late List blockTypes;
  late double showArea;
  late double opacityVal;
  late double fontSizeVal;
  late double danmakuSpeedVal;

  ///
  final PlPlayerDataStatus dataStatus = PlPlayerDataStatus();

  PreferredSizeWidget? headerControl;
  PreferredSizeWidget? bottomControl;

// 添加一个私有构造函数
  PlPlayerController._() {
    _videoType = videoType;
    isOpenDanmu.value =
        setting.get(SettingBoxKey.enableShowDanmaku, defaultValue: false);
    showArea = localCache.get(LocalCacheKey.danmakuShowArea, defaultValue: 0.5);
    // 不透明度
    opacityVal =
        localCache.get(LocalCacheKey.danmakuOpacity, defaultValue: 1.0);
    // 字体大小
    fontSizeVal =
        localCache.get(LocalCacheKey.danmakuFontScale, defaultValue: 1.0);
    // 弹幕速度
    danmakuSpeedVal =
        localCache.get(LocalCacheKey.danmakuSpeed, defaultValue: 4.0);
  }

  static PlPlayerController getInstance({
    String videoType = 'archive',
  }) {
    // 如果实例尚未创建，则创建一个新实例
    _instance ??= PlPlayerController._();
    _instance!._playerCount.value += 1;
    log("playercount+1: ${_instance!._playerCount.value}");
    _videoType.value = videoType;
    return _instance!;
  }

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
    // 解除倍速限制
    await pp.setProperty("af", "scaletempo2=max-speed=8");
    //  音量不一致
    if (Platform.isAndroid) {
      await pp.setProperty("volume-max", "100");
      await pp.setProperty("ao", "audiotrack,opensles");
    }

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
            androidAttachSurfaceAfterVideoParameters: false,
          ),
        );

    player.setPlaylistMode(looping);

    player.open(
      Media(dataSource.videoSource!, httpHeaders: dataSource.httpHeaders),
      play: false,
    );
    // 音轨
    // player.setAudioTrack(
    //   AudioTrack.uri(dataSource.audioSource!),
    // );

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
      // 初始化全屏方向
      _direction.value = direction ?? 'horizontal';
      _bvid = bvid;
      _cid = cid;
      _enableHeart = enableHeart;
      _isFirstTime = isFirstTime;

      // 初始化数据加载状态
      dataStatus.status.value = DataStatus.loading;
      if (_playerCount.value == 0) {
        return;
      }

      // 配置Player 音轨、字幕等等
      _videoPlayerController = await _createVideoController(
          dataSource, _looping, enableHA, width, height);
      // 获取视频时长 00:00
      _duration.value = duration ?? _videoPlayerController!.state.duration;
      // 数据加载完成
      dataStatus.status.value = DataStatus.loaded;

      // listen the video player events
      if (!_listenersInitialized) {
        startListeners();
      }
      await _initializePlayer(seekTo: seekTo);
    } catch (err) {
      dataStatus.status.value = DataStatus.error;
      log('plPlayer err:  $err');
    }
  }

  List<StreamSubscription> subscriptions = [];
  final List<Function(Duration position)> _positionListeners = [];
  final List<Function(PlayerStatus status)> _statusListeners = [];

  /// 播放事件监听
  startListeners() {
    subscriptions.addAll([
      videoPlayerController!.stream.playing.listen((event) {
        if (event) {
          playerStatus.status.value = PlayerStatus.playing;
        } else {
          playerStatus.status.value = PlayerStatus.paused;
        }

        for (Function(PlayerStatus status) element in _statusListeners) {
          element(event ? PlayerStatus.playing : PlayerStatus.paused);
        }
      }),
      videoPlayerController!.stream.completed.listen((event) {
        if (event) {
          playerStatus.status.value = PlayerStatus.completed;
          for (Function(PlayerStatus status) element in _statusListeners) {
            element(PlayerStatus.completed);
          }
        }
      }),
      videoPlayerController!.stream.position.listen((event) {
        _position.value = event;
        if (!_isSliderMoving.value) {
          _sliderPosition.value = event;
        }

        for (Function(Duration position) element in _positionListeners) {
          element(event);
        }
      }),
      videoPlayerController!.stream.duration.listen((event) {
        duration.value = event;
      }),
      videoPlayerController!.stream.buffer.listen((event) {
        _buffered.value = event;
      }),
    ]);
  }

  // 开始播放
  Future _initializePlayer({
    Duration seekTo = Duration.zero,
    Duration? duration,
  }) async {
    // 设置倍速
    await setPlaybackSpeed(_playbackSpeed.value);

    // if (_looping) {
    //   await setLooping(_looping);
    // }

    // 跳转播放
    if (seekTo != Duration.zero) {
      await this.seekTo(seekTo);
    }

    // 自动播放
    if (_autoPlay) {
      await play(duration: duration);
    }
  }

  Future<void> setPlaybackSpeed(double speed) async {
    await _videoPlayerController?.setRate(speed);
  }

  // 跳转至指定位置
  Future<void> seekTo(Duration position, {type = 'seek'}) async {
    if (position < Duration.zero) {
      position = Duration.zero;
    }
    _position.value = position;
    _heartDuration = position.inSeconds;

    if (duration.value.inSeconds != 0) {
      await _videoPlayerController?.seek(position);
    }
  }

  /// 播放视频
  Future<void> play({
    bool repeat = false,
    bool hideControls = true,
    dynamic duration,
  }) async {
    // repeat为true，将从头播放
    // if (repeat) {
    //   await seekTo(Duration.zero);
    // }
    await _videoPlayerController?.play();

    // await getCurrentVolume();
    // await getCurrentBrightness();

    playerStatus.status.value = PlayerStatus.playing;
    // screenManager.setOverlays(false);

    _duration.value = duration;
  }

  // 全屏
  Future<void> triggerFullScreen({bool status = true}) async {
    FullScreenMode mode = FullScreenModeCode.fromCode(
        setting.get(SettingBoxKey.fullScreenMode, defaultValue: 0))!;
    await StatusBarControl.setHidden(true, animation: StatusBarAnimation.FADE);

    if (!isFullScreen.value && status) {
      switch (mode) {
        case FullScreenMode.auto:
          if (direction.value == "horizontal") {
            // 进入全屏
            await enterFullScreen();
            // 横屏
            await landScape();
          } else {
            // 竖屏
            await verticalScreen();
          }
          break;
        case FullScreenMode.horizontal:
          // 进入全屏
          await enterFullScreen();
          // 横屏
          await landScape();
          break;
        case FullScreenMode.vertical:
          // 进入全屏
          await enterFullScreen();
          // 竖屏
          await verticalScreen();
          break;
      }

      toggleFullScreen(true);
      bool isValid =
          direction.value == 'vertical' || mode == FullScreenMode.vertical
              ? true
              : false;
      var result = await showDialog(
        context: Get.context!,
        useSafeArea: false,
        builder: (context) => Dialog.fullscreen(
          backgroundColor: Colors.black,
          child: SafeArea(
            // 忽略手机安全区域
            top: isValid,
            left: false,
            right: false,
            bottom: isValid,
            child: PLVideoPlayer(
              controller: this,
              headerControl: headerControl,
              bottomControl: bottomControl,
            ),
          ),
        ),
      );
      if (result == null) {
        exitFullScreen();
        await verticalScreen();
        toggleFullScreen(false);
      }
    } else if (isFullScreen.value) {
      StatusBarControl.setHidden(false, animation: StatusBarAnimation.FADE);
      Get.back();
      exitFullScreen();
      await verticalScreen();
      toggleFullScreen(false);
    }
  }

  void toggleFullScreen(bool val) {
    _isFullScreen.value = val;
  }

  // 还原默认速度
  Future<void> setDefaultSpeed() async {
    double speed =
        videoStorage.get(VideoBoxKey.playSpeedDefault, defaultValue: 1.0);
    await _videoPlayerController?.setRate(speed);
    _playbackSpeed.value = speed;
  }

  Future<void> dispose({String type = 'single'}) async {
    // 每次减1，最后销毁
    if (type == 'single' && playerCount.value > 1) {
      _playerCount.value -= 1;
      log("_playerCount-1: ${_playerCount.value}");
      _heartDuration = 0;
      pause();
      return;
    }

    log("_playerCount is 0");

    _playerCount.value = 0;

    try {
      await _videoPlayerController?.dispose();
      _videoPlayerController = null;
      _instance = null;
    } catch (error) {
      log(error.toString());
    }
  }

  /// 暂停播放
  Future<void> pause({bool notify = true, bool isInterrupt = false}) async {
    await _videoPlayerController?.pause();
    playerStatus.status.value = PlayerStatus.paused;
  }

  void onChangedSliderStart() {
    _isSliderMoving.value = true;
  }

  void onChangedSliderEnd() {
    _isSliderMoving.value = false;
  }

  void onUpdatedSliderProgress(Duration value) {
    _sliderPosition.value = value;
  }

  /// 调整播放时间
  onChangedSlider(double v) {
    _sliderPosition.value = Duration(seconds: v.floor());
  }

  void addPositionListener(Function(Duration position) listener) =>
      _positionListeners.add(listener);
  void removePositionListener(Function(Duration position) listener) =>
      _positionListeners.remove(listener);
  void addStatusLister(Function(PlayerStatus status) listener) =>
      _statusListeners.add(listener);
  void removeStatusLister(Function(PlayerStatus status) listener) =>
      _statusListeners.remove(listener);
}
