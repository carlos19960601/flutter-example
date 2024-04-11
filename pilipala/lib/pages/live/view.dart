import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pilipala/common/constants.dart';
import 'package:pilipala/common/skeleton/video_card_v.dart';
import 'package:pilipala/common/widgets/http_error.dart';
import 'package:pilipala/pages/live/controller.dart';
import 'package:pilipala/pages/live/widgets/live_item.dart';
import 'package:pilipala/pages/main/controller.dart';

class LivePage extends StatefulWidget {
  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage>
    with AutomaticKeepAliveClientMixin {
  final LiveController _liveController = Get.put(LiveController());
  late Future _futureBuilderFuture;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _futureBuilderFuture = _liveController.queryLiveList('init');
    scrollController = _liveController.scrollController;
    StreamController<bool> mainStream =
        Get.find<MainController>().bottomBarStream;

    scrollController.addListener(
      () {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
          EasyThrottle.throttle('liveList', const Duration(seconds: 1), () {
            _liveController.isLoadingMore = true;
            _liveController.onLoad();
          });
        }

        final ScrollDirection direction =
            scrollController.position.userScrollDirection;
        if (direction == ScrollDirection.forward) {
          mainStream.add(true);
        } else if (direction == ScrollDirection.reverse) {
          mainStream.add(false);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(
          left: StyleString.safeSpace, right: StyleString.safeSpace),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(StyleString.imgRadius),
      ),
      child: RefreshIndicator(
          child: CustomScrollView(
            controller: _liveController.scrollController,
            slivers: [
              SliverPadding(
                padding:
                    const EdgeInsets.fromLTRB(0, StyleString.safeSpace, 0, 0),
                sliver: FutureBuilder(
                    future: _futureBuilderFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data == null) {
                          return const SliverToBoxAdapter(child: SizedBox());
                        }
                        Map data = snapshot.data as Map;
                        if (data['status']) {
                          return SliverLayoutBuilder(
                              builder: (context, boxConstraints) {
                            return Obx(() => contentGrid(
                                _liveController, _liveController.liveList));
                          });
                        } else {
                          return HttpError(
                            errMsg: data['msg'],
                            fn: () => {},
                          );
                        }
                      } else {
                        // 缓存数据
                        if (_liveController.liveList.length > 1) {
                          return contentGrid(
                              _liveController, _liveController.liveList);
                        }
                        // 骨架屏
                        else {
                          return contentGrid(_liveController, []);
                        }
                      }
                    }),
              )
            ],
          ),
          onRefresh: () async {
            return await _liveController.onRefresh();
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget contentGrid(ctr, liveList) {
    int crossAxisCount = ctr.crossAxisCount.value;
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // 行间距
        mainAxisSpacing: StyleString.safeSpace,
        // 列间距
        crossAxisSpacing: StyleString.safeSpace,
        // 列数
        crossAxisCount: crossAxisCount,
        mainAxisExtent:
            Get.size.width / crossAxisCount / StyleString.aspectRatio +
                (crossAxisCount == 1 ? 48 : 68) *
                    MediaQuery.of(context).textScaleFactor,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return liveList!.isNotEmpty
              ? LiveCardV(
                  liveItem: liveList[index],
                  crossAxisCount: crossAxisCount,
                  longPress: () {},
                  longPressEnd: () {},
                )
              : const VideoCardVSkeleton();
        },
        childCount: liveList!.isNotEmpty ? liveList!.length : 10,
      ),
    );
  }
}
