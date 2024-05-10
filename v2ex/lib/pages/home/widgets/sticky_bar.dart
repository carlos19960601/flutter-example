import 'package:flutter/material.dart';
import 'package:v2ex/models/tabs.dart';

class HomeStickyBar extends StatelessWidget {
  const HomeStickyBar({super.key, required this.tabs, required this.ctr});

  final List<TabModel> tabs;
  final TabController ctr;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AdpatTabBar(
            controller: ctr,
            tabs: tabs,
            onTap: (index) {},
          ),
        ),
      ],
    );
  }
}

class AdpatTabBar extends StatelessWidget {
  const AdpatTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.onTap,
  });

  final List<TabModel> tabs;
  final TabController? controller;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: tabs
          .map(
            (e) => Tab(
              text: e.name,
            ),
          )
          .toList(),
    );
  }
}
