import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/common/constants.dart';
import 'package:pilipala/common/skeleton/video_card_h.dart';
import 'package:pilipala/pages/hot/controller.dart';

class HotPage extends StatefulWidget {
  const HotPage({super.key});

  @override
  State<HotPage> createState() => _HotPageState();
}

class _HotPageState extends State<HotPage> {
  final HotController _hotController = Get.put(HotController());
  List videoList = [];
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = _hotController.scrollController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          return;
        },
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPadding(
              padding:
                  const EdgeInsets.fromLTRB(0, StyleString.safeSpace - 5, 0, 0),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return const VideoCardHSkeleton();
                },
                childCount: 10,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
