import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pilipala/common/constants.dart';
import 'package:pilipala/common/skeleton/video_card_v.dart';
import 'package:pilipala/common/widgets/http_error.dart';
import 'package:pilipala/common/widgets/video_card_v.dart';
import 'package:pilipala/models/home/rcmd/result.dart';
import 'package:pilipala/pages/main/controller.dart';
import 'package:pilipala/pages/rcmd/controller.dart';

class RcmdPage extends StatefulWidget {
  const RcmdPage({super.key});

  @override
  State<RcmdPage> createState() => _RcmdPageState();
}

class _RcmdPageState extends State<RcmdPage>
    with AutomaticKeepAliveClientMixin {
  final RcmdController _rcmdController = Get.put(RcmdController());
  late Future _futureBuilderFuture;

  @override
  void initState() {
    super.initState();
    ScrollController scrollController = _rcmdController.scrollController;
    _futureBuilderFuture = _rcmdController.queryRcmdFeed("init");
    StreamController<bool> mainStream =
        Get.find<MainController>().bottomBarStream;

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        EasyThrottle.throttle(
          "my-throttler",
          const Duration(milliseconds: 500),
          () {
            _rcmdController.isLoadingMore = true;
            _rcmdController.onLoad();
          },
        );
      }

      final ScrollDirection direction =
          scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.forward) {
        mainStream.add(true);
      } else if (direction == ScrollDirection.reverse) {
        mainStream.add(false);
      }
    });
  }

  @override
  void dispose() {
    _rcmdController.scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(
        left: StyleString.safeSpace,
        right: StyleString.safeSpace,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          StyleString.imgRadius,
        ),
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          await _rcmdController.onRefresh();
          await Future.delayed(const Duration(milliseconds: 300));
        },
        child: CustomScrollView(
          controller: _rcmdController.scrollController,
          slivers: [
            SliverPadding(
              padding:
                  const EdgeInsets.fromLTRB(0, StyleString.safeSpace, 0, 0),
              sliver: FutureBuilder(
                future: _futureBuilderFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map data = snapshot.data as Map;
                    if (data["status"]) {
                      return Obx(() => contentGrid(
                          _rcmdController, _rcmdController.videoList));
                    } else {
                      return HttpError(
                        errMsg: data['msg'],
                        fn: () {
                          setState(() {
                            _futureBuilderFuture =
                                _rcmdController.queryRcmdFeed('init');
                          });
                        },
                      );
                    }
                  } else {
                    // 使用历史缓存
                    if (_rcmdController.videoList.isNotEmpty) {
                      return contentGrid(
                          _rcmdController, _rcmdController.videoList);
                    } else {
                      return contentGrid(_rcmdController, []);
                    }
                  }
                },
              ),
            ),
            const LoadingMore(),
          ],
        ),
      ),
    );
  }

  Widget contentGrid(RcmdController ctr, List<RecVideoItemAppModel> videoList) {
    int crossAxisCount = ctr.crossAxisCount.value;
    double mainAxisExtent =
        (Get.size.width / crossAxisCount / StyleString.aspectRatio) +
            (crossAxisCount == 1
                ? 68
                : 86 * MediaQuery.of(context).textScaleFactor);

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return videoList.isNotEmpty
              ? VideoCardV(
                  videoItem: videoList[index],
                  crossAxisCount: crossAxisCount,
                  longPress: () {},
                )
              : const VideoCardVSkeleton();
        },
        childCount: videoList!.isNotEmpty ? videoList!.length : 10,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // 行间距
        mainAxisSpacing: StyleString.safeSpace,
        // 列间距
        crossAxisSpacing: StyleString.safeSpace,
        crossAxisCount: crossAxisCount,
        mainAxisExtent: mainAxisExtent,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class LoadingMore extends StatelessWidget {
  const LoadingMore({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).padding.bottom + 80,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Center(
          child: Text(
            "加载中...",
            style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
