import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/models/dynamics/result.dart';
import 'package:pilipala/pages/dynamics/controller.dart';
import 'package:pilipala/pages/dynamics/widgets/up_panel.dart';
import 'package:pilipala/pages/main/controller.dart';
import 'package:pilipala/utils/storage.dart';

class DynamicsPage extends StatefulWidget {
  const DynamicsPage({super.key});

  @override
  State<DynamicsPage> createState() => _DynamicsPageState();
}

class _DynamicsPageState extends State<DynamicsPage>
    with AutomaticKeepAliveClientMixin {
  DynamicsController _dynamicsController = Get.put(DynamicsController());
  late Future _futureBulderFuture;
  late Future _futureBuilderFutureUp;
  Box userInfoCache = GStorage.userInfo;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _futureBulderFuture = _dynamicsController.queryFollowDynamic();
    _futureBuilderFutureUp = _dynamicsController.queryFollowUp();
    scrollController = _dynamicsController.scrollController;
    StreamController<bool> mainStream =
        Get.find<MainController>().bottomBarStream;

    scrollController.addListener(() {});

    _dynamicsController.userLogin.listen((status) {
      if (mounted) {
        setState(() {
          _futureBulderFuture = _dynamicsController.queryFollowDynamic();
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
        title: SizedBox(
          height: 34,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
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
                      })
                    ],
                  ),
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
                    return const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 36,
                      ),
                    );
                  }
                  Map data = snapshot.data;
                  if (data["status"]) {
                    return Obx(() => UpPanel(_dynamicsController.upData.value));
                  } else {
                    return const SliverToBoxAdapter(
                      child: SizedBox(height: 80),
                    );
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
              future: _futureBulderFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) {
                    return const SliverToBoxAdapter(
                      child: const SizedBox(),
                    );
                  }
                  Map data = snapshot.data as Map;
                  if (data["status"]) {
                    List<DynamicItemModel> list =
                        _dynamicsController.dynamicsList;
                    return Obx(() {
                      if (list.isEmpty) {
                        if (_dynamicsController.isLoadingDynamic.value) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text("加载中..."),
                            ),
                          );
                        } else {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text("没有数据"),
                            ),
                          );
                        }
                      } else {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Text("动态"),
                          ),
                        );
                      }
                    });
                  } else {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text("Loading"),
                      ),
                    );
                  }
                } else {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text("网络问题"),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
