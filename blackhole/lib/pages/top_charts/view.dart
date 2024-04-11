import 'package:flutter/material.dart';
import 'package:blackhole/localization/translation_keys.dart'
    as translation_keys;
import 'package:get/get.dart';

class TopCharts extends StatefulWidget {
  const TopCharts({super.key, required this.pageController});

  final PageController pageController;
  @override
  State<TopCharts> createState() => _TopChartsState();
}

class _TopChartsState extends State<TopCharts> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            translation_keys.spotifyCharts.tr,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  translation_keys.local.tr,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  translation_keys.global.tr,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
              )
            ],
          ),
        ),
        body: const TabBarView(children: []),
      ),
    );
  }
}
