import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/common/constants.dart';
import 'package:pilipala/common/widgets/http_error.dart';
import 'package:pilipala/models/home/rcmd/result.dart';
import 'package:pilipala/pages/rcmd/controller.dart';

class RcmdPage extends StatefulWidget {
  const RcmdPage({super.key});

  @override
  State<RcmdPage> createState() => _RcmdPageState();
}

class _RcmdPageState extends State<RcmdPage> {
  final RcmdController _rcmdController = Get.put(RcmdController());
  late Future _futureBuilderFuture;

  @override
  void initState() {
    super.initState();
    _futureBuilderFuture = _rcmdController.queryRcmdFeed("init");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      return Platform.isAndroid || Platform.isIOS
                          ? Obx(() => contentGrid(
                              _rcmdController, _rcmdController.videoList))
                          : SliverLayoutBuilder(
                              builder: (context, constraints) {
                                return Obx(() => contentGrid(_rcmdController,
                                    _rcmdController.videoList));
                              },
                            );
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
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget contentGrid(RcmdController ctr, List<RecVideoItemAppModel> videoList) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount());
  }
}
