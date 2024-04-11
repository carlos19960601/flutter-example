import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/models/common/search_type.dart';
import 'package:pilipala/pages/bangumi/introduction/view.dart';
import 'package:pilipala/pages/video/detail/controller.dart';
import 'package:pilipala/pages/video/detail/introduction/controller.dart';
import 'package:pilipala/pages/video/detail/introduction/view.dart';
import 'package:pilipala/pages/video/detail/related/view.dart';
import 'package:pilipala/pages/video/detail/reply/view.dart';
import 'package:pilipala/plugin/pl_player/controller.dart';
import 'package:pilipala/plugin/pl_player/models/play_repeat.dart';
import 'package:pilipala/plugin/pl_player/models/play_status.dart';
import 'package:pilipala/plugin/pl_player/view.dart';
import 'package:pilipala/utils/storage.dart';

class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
}

class _VideoDetailPageState extends State<VideoDetailPage> with RouteAware {
  late String heroTag;
  late VideoDetailController videoDetailController;
  PlPlayerController? plPlayerController;
  final ScrollController _extendNestCtr = ScrollController();
  late VideoIntroController videoIntroController;
  late Future _futureBuilderFuture;
  late double statusBarHeight;
  Box localCache = GStorage.localCache;
  Box setting = GStorage.setting;
  // 自动退出全屏
  late bool autoExitFullscreen;
  late bool autoPlayEnable;

  @override
  void initState() {
    super.initState();
    heroTag = Get.arguments["heroTag"];
    videoDetailController = Get.put(VideoDetailController(), tag: heroTag);
    videoIntroController = Get.put(VideoIntroController(), tag: heroTag);
    statusBarHeight = localCache.get('statusBarHeight');
    autoExitFullscreen =
        setting.get(SettingBoxKey.enableAutoExit, defaultValue: false);
    autoPlayEnable =
        setting.get(SettingBoxKey.autoPlayEnable, defaultValue: true);
    videoSourceInit();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    VideoDetailPage.routeObserver
        .subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  Future<void> videoSourceInit() async {
    _futureBuilderFuture = videoDetailController.queryVideoUrl();
    if (videoDetailController.autoPlay.value) {
      plPlayerController = videoDetailController.plPlayerController;
      plPlayerController!.addStatusLister(playerListener);
    }
  }

  void playerListener(PlayerStatus status) async {
    if (status == PlayerStatus.completed) {
      if (autoExitFullscreen) {
        plPlayerController!.triggerFullScreen(status: false);
      }

      if (plPlayerController!.playRepeat != PlayRepeat.pause &&
          plPlayerController!.playRepeat != PlayRepeat.singleCycle) {}

      if (plPlayerController!.playRepeat == PlayRepeat.singleCycle) {
        plPlayerController!.seekTo(Duration.zero);
        plPlayerController!.play();
      }
    }
  }

  Future<void> handlePlay() async {
    await videoDetailController.playerInit();
    videoDetailController.autoPlay.value = true;
  }

  @override
  Widget build(BuildContext context) {
    final videoHeight = MediaQuery.of(context).size.width * 9 / 16;
    Widget childWhenDisabled = SafeArea(
      top: false,
      bottom: false,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.black,
            body: NestedScrollView(
              controller: _extendNestCtr,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.black,
                    expandedHeight: videoHeight,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: EdgeInsets.only(top: statusBarHeight),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double maxWidth = constraints.maxWidth;
                            double maxHeight = constraints.maxHeight;
                            return Stack(
                              children: [
                                FutureBuilder(
                                  future: _futureBuilderFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data["status"]) {
                                      return Obx(
                                        () => !videoDetailController
                                                .autoPlay.value
                                            ? const SizedBox()
                                            : PLVideoPlayer(
                                                controller: plPlayerController!,
                                                headerControl:
                                                    videoDetailController
                                                        .headerControl,
                                              ),
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: Container(
                key: Key(heroTag),
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  children: [
                    Opacity(
                      opacity: 0,
                      child: SizedBox(
                        width: double.infinity,
                        height: 0,
                        child: Obx(
                          () => TabBar(
                            controller: videoDetailController.tabCtr,
                            tabs: videoDetailController.tabs
                                .map((String name) => Tab(text: name))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: videoDetailController.tabCtr,
                        children: [
                          Builder(
                            builder: (context) {
                              return CustomScrollView(
                                slivers: [
                                  if (SearchType.video ==
                                      videoDetailController.videoType) ...[
                                    const VideoIntroPanel(),
                                  ] else if (SearchType.media_bangumi ==
                                      videoDetailController.videoType) ...[
                                    Obx(
                                      () => BangumiIntroPanel(
                                          cid: videoDetailController.cid.value),
                                    ),
                                  ],
                                  SliverToBoxAdapter(
                                    child: Divider(
                                      indent: 12,
                                      endIndent: 12,
                                      color: Theme.of(context)
                                          .dividerColor
                                          .withOpacity(0.06),
                                    ),
                                  ),
                                  const RelatedVideoPanel(),
                                ],
                              );
                            },
                          ),
                          VideoReplyPanel(bvid: videoDetailController.bvid),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );

    return childWhenDisabled;
  }

  @override
  // 返回当前页面时
  void didPopNext() async {
    bool autoplay = autoPlayEnable;
    videoDetailController.playerInit(autoplay: autoplay);

    if (autoplay) {
      await Future.delayed(const Duration(milliseconds: 300));
      plPlayerController!.seekTo(videoDetailController.defaultST);
      plPlayerController?.play();
    }
    super.didPopNext();
  }

  @override
  // 离开当前页面时
  void didPushNext() {
    if (plPlayerController != null) {
      videoDetailController.defaultST = plPlayerController!.position.value;
      plPlayerController!.pause();
    }
    super.didPushNext();
  }

  @override
  void dispose() {
    if (plPlayerController != null) {
      plPlayerController!.dispose();
    }
    super.dispose();
  }
}
