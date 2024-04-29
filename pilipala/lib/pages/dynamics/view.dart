import 'dart:async';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/common/skeleton/dynamic_card.dart';
import 'package:pilipala/common/widgets/http_error.dart';
import 'package:pilipala/common/widgets/no_data.dart';
import 'package:pilipala/models/dynamics/result.dart';
import 'package:pilipala/pages/dynamics/controller.dart';
import 'package:pilipala/pages/dynamics/widgets/dynamic_panel.dart';
import 'package:pilipala/pages/dynamics/widgets/up_panel.dart';
import 'package:pilipala/pages/main/controller.dart';
import 'package:pilipala/pages/mine/controller.dart';
import 'package:pilipala/utils/feed_back.dart';
import 'package:pilipala/utils/storage.dart';

class DynamicsPage extends StatefulWidget {
  const DynamicsPage({super.key});

  @override
  State<DynamicsPage> createState() => _DynamicsPageState();
}

class _DynamicsPageState extends State<DynamicsPage>
    with AutomaticKeepAliveClientMixin {
  final DynamicsController _dynamicsController = Get.put(DynamicsController());
  final MineController mineController = Get.put(MineController());
  late Future _futureBuilderFuture;
  late Future _futureBuilderFutureUp;
  Box userInfoCache = GStorage.userInfo;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _futureBuilderFuture = _dynamicsController.queryFollowDynamic();
    _futureBuilderFutureUp = _dynamicsController.queryFollowUp();
    scrollController = _dynamicsController.scrollController;
    StreamController<bool> mainStream =
        Get.find<MainController>().bottomBarStream;

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        EasyThrottle.throttle('queryFollowDynamic', const Duration(seconds: 1),
            () {
          _dynamicsController.queryFollowDynamic(type: 'onLoad');
        });

        final ScrollDirection direction =
            scrollController.position.userScrollDirection;
        if (direction == ScrollDirection.forward) {
          mainStream.add(true);
        } else if (direction == ScrollDirection.reverse) {
          mainStream.add(false);
        }
      }
    });

    _dynamicsController.userLogin.listen((status) {
      if (mounted) {
        setState(() {
          _futureBuilderFuture = _dynamicsController.queryFollowDynamic();
          _futureBuilderFutureUp = _dynamicsController.queryFollowUp();
        });
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
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        title: SizedBox(
          height: 34,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 选择了某个up
                  Obx(
                    () {
                      if (_dynamicsController.mid.value != -1 &&
                          _dynamicsController.upInfo.value.uname != null) {
                        return SizedBox(
                          height: 36,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Text(
                              '${_dynamicsController.upInfo.value.uname!}的动态',
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .fontSize,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  // 所有up
                  Obx(() => _dynamicsController.userLogin.value
                      ? Visibility(
                          visible: _dynamicsController.mid.value == -1,
                          child: Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child: CustomSlidingSegmentedControl<int>(
                              padding: 13.0,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant
                                    .withOpacity(0.7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              thumbDecoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              initialValue:
                                  _dynamicsController.initialValue.value,
                              onValueChanged: (int v) {
                                feedback();
                                _dynamicsController.onSelectType(v);
                              },
                              children: {
                                0: Text(
                                  '全部',
                                  style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .fontSize),
                                ),
                                1: Text('投稿',
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .fontSize)),
                                2: Text('番剧',
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .fontSize)),
                                3: Text('专栏',
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .fontSize)),
                              },
                            ),
                          ),
                        )
                      : Text('动态',
                          style: Theme.of(context).textTheme.titleMedium)),
                ],
              )
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _dynamicsController.onRefresh(),
        child: CustomScrollView(
          controller: _dynamicsController.scrollController,
          slivers: [
            FutureBuilder(
              future: _futureBuilderFutureUp,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) {
                    return const SliverToBoxAdapter(child: SizedBox());
                  }
                  Map data = snapshot.data;
                  if (data["status"]) {
                    return Obx(() => UpPanel(_dynamicsController.upData.value));
                  } else {
                    return const SliverToBoxAdapter(
                        child: SizedBox(height: 80));
                  }
                } else {
                  return const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 90,
                      child: UpPanelSkeleton(),
                    ),
                  );
                }
              },
            ),
            FutureBuilder(
              future: _futureBuilderFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) {
                    return const SliverToBoxAdapter(child: SizedBox());
                  }
                  Map data = snapshot.data as Map;
                  if (data["status"]) {
                    List<DynamicItemModel> list =
                        _dynamicsController.dynamicsList;
                    return Obx(() {
                      if (list.isEmpty) {
                        if (_dynamicsController.isLoadingDynamic.value) {
                          // 骨架屏
                          return skeleton();
                        } else {
                          return const NoData();
                        }
                      } else {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return DynamicPanel(item: list[index]);
                            },
                            childCount: list.length,
                          ),
                        );
                      }
                    });
                  } else if (data["msg" == "账号未登录"]) {
                    return HttpError(
                      errMsg: data['msg'],
                      btnText: "去登录",
                      fn: () {
                        mineController.onLogin();
                      },
                    );
                  } else {
                    return HttpError(
                      errMsg: data['msg'],
                      fn: () {
                        setState(() {
                          _futureBuilderFuture =
                              _dynamicsController.queryFollowDynamic();
                          _futureBuilderFutureUp =
                              _dynamicsController.queryFollowUp();
                        });
                      },
                    );
                  }
                } else {
                  // 骨架屏
                  return skeleton();
                }
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  Widget skeleton() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return const DynamicCardSkeleton();
      }, childCount: 5),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
