import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/found/view.dart';
import 'package:flutter_cloud_music/pages/home/controller.dart';
import 'package:flutter_cloud_music/pages/home/widgets/bottom_bar.dart';
import 'package:flutter_cloud_music/pages/mine/view.dart';
import 'package:flutter_cloud_music/pages/podcast/view.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        extendBody: false,
        body: Stack(
          children: [
            Positioned.fill(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                onPageChanged: controller.changePage,
                children: [
                  FoundPage(),
                  const PodcastPage(),
                  MinePage(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: HomeBottomBar(),
      ),
    );
  }
}
