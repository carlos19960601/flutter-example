import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/logger.dart';
import 'package:flutter_cloud_music/models/video_count_info.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widgets/video/state.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

typedef LoadMoreVideo = Future<List<VPVideoController>> Function(
  int index,
  List<VPVideoController> list,
);

class VideoListController extends ChangeNotifier {
  VideoListController({
    this.loadMoreCount = 1,
    this.preloadCount = 3,
    this.disposeCount = 5,
  });

  /// 到第几个触发预加载，例如：1:最后一个，2:倒数第二个
  final int loadMoreCount;

  /// 预加载多少个视频
  final int preloadCount;

  /// 超出多少个，就释放视频
  final int disposeCount;

  /// 提供视频的builder
  LoadMoreVideo? _videoProvider;

  /// 视频列表
  List<VPVideoController> playerList = [];

  /// 视频总数目
  int get videoCount => playerList.length;

  void init({
    required PageController pageController,
    required List<VPVideoController> initialList,
    required LoadMoreVideo videoProvider,
    int startIndex = 0,
  }) {
    playerList.addAll(initialList);
    _videoProvider = videoProvider;
    pageController.addListener(() {
      final p = pageController.page!;
      if (p % 1 == 0) {
        loadIndex(p ~/ 1);
      }
      loadIndex(startIndex, reload: true);
      notifyListeners();
    });
  }

  /// 获取指定index的player
  VPVideoController? playerOfIndex(int index) {
    if (index < 0 || index > playerList.length - 1) {
      return null;
    }
    return playerList[index];
  }

  void loadIndex(int target, {bool reload = false}) {
    logger.i("target: $target reload: $reload");
    if (!reload) {
      if (index.value == target) return;
    }

    // 播放当前的，暂停其他的
    final oldIndex = index.value;
    final newIndex = target;
    // 暂停之前的视频
    if (!(oldIndex == 0 && newIndex == 0)) {
      playerOfIndex(oldIndex)?.controllerValue?.seekTo(Duration.zero);
      playerOfIndex(oldIndex)?.pause();
      logger.d('暂停$oldIndex');
    }

    playerOfIndex(newIndex)?.play();
    // 处理预加载/释放内存
    for (var i = 0; i < playerList.length; i++) {
      // 需要预加载
      if (i > newIndex && i < newIndex + preloadCount) {
        logger.d('预加载$i');
        playerOfIndex(i)?.init();
      }
    }
  }

  /// 目前的视频序号
  ValueNotifier<int> index = ValueNotifier<int>(0);

  @override
  void dispose() {
    for (final player in playerList) {
      player.dispose();
    }
    playerList = [];
    super.dispose();
  }
}

typedef ControllerSetter<T> = Future<void> Function(T controller);
typedef ControllerGetter<T> = Future<T> Function();
typedef ControllerBuilder<T> = T Function();

/// 抽象类，作为视频控制器必须实现这些方法
abstract class TikTokVideoController<T> {
  /// 加载视频，在init后，应当开始下载视频内容
  Future<void> init({ControllerSetter<T?>? afterInit});

  /// 视频销毁，在dispose后，应当释放任何内存资源
  Future<void> dispose();

  /// 播放
  Future<void> play();

  /// 暂停
  Future<void> pause({bool showPause = true});
}

class VPVideoController extends TikTokVideoController<VideoPlayerController> {
  VPVideoController({
    required this.videoModel,
    required ControllerGetter<VideoPlayerController> builder,
    ControllerGetter<VideoCountInfo>? countInfo,
    ControllerGetter<dynamic>? info,
    ControllerSetter<VideoPlayerController?>? afterInit,
  })  : _builder = builder,
        _countInfo = countInfo,
        _info = info,
        _afterInit = afterInit;

  final VideoModel videoModel;

  final ControllerGetter<VideoPlayerController> _builder;
  final ControllerGetter<VideoCountInfo>? _countInfo;
  final ControllerGetter<dynamic>? _info;
  final ControllerSetter<VideoPlayerController?>? _afterInit;

  final Rxn<VideoPlayerController> controller = Rxn<VideoPlayerController>();
  VideoPlayerController? get controllerValue => controller.value;

  ///视频信息 创建者 描述等
  final Rxn<dynamic> info = Rxn<dynamic>();

  ///点赞/评论/分享数量信息
  final Rxn<VideoCountInfo> countInfo = Rxn<VideoCountInfo>();

  bool get prepared => _prepared;
  bool _prepared = false;

  Future<void> _initController() async {
    controller.value ??= await _builder.call();
    return;
  }

  @override
  Future<void> dispose() async {
    if (!prepared) return;
    _prepared = false;
  }

  @override
  Future<void> init(
      {ControllerSetter<VideoPlayerController?>? afterInit}) async {
    if (prepared) return;
    _requestVideoInfo();
    await _initController();
    await controllerValue?.initialize();
    await controllerValue?.setLooping(true);
    afterInit ??= _afterInit;
    await afterInit?.call(controllerValue);
    _prepared = true;
  }

  ///请求视频数据 信息点赞评论数等
  Future<void> _requestVideoInfo() async {
    if (countInfo.value == null && _countInfo != null) {
      if (videoModel.resource != null) {
        final logExtVO = videoModel.resource!.mlogExtVO;
        countInfo.value =
            VideoCountInfo(logExtVO.likedCount, 0, logExtVO.commentCount);
      }
      _countInfo.call().then((value) {
        countInfo.value = value;
      });
    }
    if (info.value == null && _info != null) {
      _info.call().then((value) {
        info.value = value;
      });
    }
  }

  @override
  Future<void> pause({bool showPause = true}) {
    throw UnimplementedError();
  }

  @override
  Future<void> play() {
    throw UnimplementedError();
  }
}
