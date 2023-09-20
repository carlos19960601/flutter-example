import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pilipala/common/constants.dart';
import 'package:pilipala/common/skeleton/video_card_h.dart';
import 'package:pilipala/common/widgets/http_error.dart';
import 'package:pilipala/common/widgets/video_card_h.dart';
import 'package:pilipala/pages/hot/controller.dart';
import 'package:pilipala/pages/main/controller.dart';

class HotPage extends StatefulWidget {
  const HotPage({super.key});

  @override
  State<HotPage> createState() => _HotPageState();
}

class _HotPageState extends State<HotPage> with AutomaticKeepAliveClientMixin {
  final HotController _hotController = Get.put(HotController());
  List videoList = [];
  late ScrollController scrollController;
  Future? _futureBuilderFuture;

  @override
  void initState() {
    super.initState();
    _futureBuilderFuture = _hotController.queryHotFeed("init");
    scrollController = _hotController.scrollController;
    StreamController<bool> mainStream =
        Get.find<MainController>().bottomBarStream;

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        if (!_hotController.isLoadingMore) {
          _hotController.isLoadingMore = true;
          _hotController.onLoad();
        }
      }

      final ScrollDirection direction =
          scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.forward) {
        mainStream.add(true);
      } else {
        mainStream.add(false);
      }
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          return await _hotController.onRefresh();
        },
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPadding(
              padding:
                  const EdgeInsets.fromLTRB(0, StyleString.safeSpace - 5, 0, 0),
              sliver: FutureBuilder(
                future: _futureBuilderFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map data = snapshot.data as Map;
                    if (data["status"]) {
                      return Obx(
                        () => SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            return VideoCardH(
                              videoItem: _hotController.videoList[index],
                            );
                          }, childCount: _hotController.videoList.length),
                        ),
                      );
                    }
                    return HttpError(
                        errMsg: data["msg"], fn: () => setState(() {}));
                  } else {
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return const VideoCardHSkeleton();
                      },
                      childCount: 10,
                    ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );

    //       sliver: FutureBuilder(
    //         future: _futureBuilderFuture,
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState == ConnectionState.done) {
    //             Map data = snapshot.data as Map;
    //             if (data["status"]) {
    //               return Obx(
    //                 () => SliverList(
    //                   delegate: SliverChildBuilderDelegate(
    //                     (context, index) {
    //                       return VideoCardH(
    //                         videoItem: _hotController.videoList[index],
    //                         longPress: () {},
    //                         longPressEnd: () {},
    //                       );
    //                     },
    //                     childCount: _hotController.videoList.length,
    //                   ),
    //                 ),
    //               );
    //             } else {
    //               return HttpError(
    //                 errMsg: data["msg"],
    //                 fn: () => setState(() {}),
    //               );
    //             }
    //           } else {
    //             return SliverList(
    //               delegate: SliverChildBuilderDelegate(
    //                 (context, index) {
    //                   return const VideoCardHSkeleton();
    //                 },
    //               ),
    //             );
    //           }
    //         },
    //       ),
    //     )
    //   ],
    // ),
    // ),
    // );
  }

  @override
  bool get wantKeepAlive => true;
}
