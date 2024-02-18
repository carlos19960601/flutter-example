import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/singer_detail/controller.dart';
import 'package:get/get.dart';

class SingerTabs extends StatefulWidget {
  const SingerTabs({super.key, required this.controller});
  final SingerDetailController controller;

  @override
  State<SingerTabs> createState() => _SingerTabsState();
}

class _SingerTabsState extends State<SingerTabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.cardColor,
      height: 40,
      child: TabBar(
        controller: widget.controller.state.tabController,
        tabs: tabsWidget(),
      ),
    );
  }

  List<Widget> tabsWidget() {
    return widget.controller.state.tabs!
        .map((e) => Tab(
              child: Row(
                children: [
                  Text(e.title),
                  if ((e.num ?? 0) > 0)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 2,
                        left: 1,
                      ),
                      child: Text(
                        e.num! >= 1000 ? "999+" : e.num.toString(),
                        style: const TextStyle(
                          fontSize: 9,
                        ),
                      ),
                    ),
                ],
              ),
            ))
        .toList();
  }
}
