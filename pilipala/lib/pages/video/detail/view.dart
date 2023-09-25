import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/pages/video/detail/controller.dart';
import 'package:pilipala/pages/video/detail/reply/view.dart';
import 'package:pilipala/plugin/pl_player/controller.dart';
import 'package:pilipala/plugin/pl_player/view.dart';
import 'package:pilipala/utils/storage.dart';

class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> with RouteAware {
  late String heroTag;
  late VideoDetailController videoDetailController;
  PlPlayerController? plPlayerController;
  final ScrollController _extendNestCtr = ScrollController();
  late Future _futureBuilderFuture;
  late double statusBarHeight;
  Box localCache = GStorage.localCache;
  Box setting = GStorage.setting;

  @override
  void initState() {
    super.initState();
    heroTag = Get.arguments["heroTag"];
    videoDetailController = Get.put(VideoDetailController(), tag: heroTag);
    statusBarHeight = localCache.get('statusBarHeight');
    videoSouceInit();
  }

  Future<void> videoSouceInit() async {
    _futureBuilderFuture = videoDetailController.queryVideoUrl();
    if (videoDetailController.autoPlay.value) {
      plPlayerController = videoDetailController.plPlayerController;
    }
  }

  Future<void> handlePlay() async {
    await videoDetailController.playeInit();
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
                                      return Obx(() => !videoDetailController
                                              .autoPlay.value
                                          ? const SizedBox()
                                          : PLVideoPlayer(
                                              controller: plPlayerController!,
                                              headerControl:
                                                  videoDetailController
                                                      .headerControl,
                                            ));
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
                              return CustomScrollView();
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
  void didPopNext() {
    super.didPopNext();
  }
}
