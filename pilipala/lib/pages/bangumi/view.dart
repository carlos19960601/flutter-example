import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pilipala/pages/bangumi/controller.dart';
import 'package:pilipala/pages/main/controller.dart';
import 'package:pilipala/pages/rcmd/view.dart';

class BangumiPage extends StatefulWidget {
  const BangumiPage({super.key});

  @override
  State<BangumiPage> createState() => _BangumiPageState();
}

class _BangumiPageState extends State<BangumiPage>
    with AutomaticKeepAliveClientMixin {
  final BangumiController _bangumiController = Get.put(BangumiController());
  late Future? _futureBuilderFuture;
  late Future? _futureBuilderFutureFollow;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = _bangumiController.scrollController;
    StreamController<bool> mainStream =
        Get.find<MainController>().bottomBarStream;
    _futureBuilderFuture = _bangumiController.queryBangumiListFeed();
    _futureBuilderFutureFollow = _bangumiController.queryBangumiFollow();
    scrollController.addListener(
      () async {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
          EasyThrottle.throttle('my-throttler', const Duration(seconds: 1), () {
            _bangumiController.isLoadingMore = true;
            _bangumiController.onLoad();
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
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      child: CustomScrollView(
        controller: _bangumiController.scrollController,
        slivers: [LoadingMore()],
      ),
      onRefresh: () async {
        await _bangumiController.queryBangumiListFeed(type: 'init');
        return _bangumiController.queryBangumiFollow();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
