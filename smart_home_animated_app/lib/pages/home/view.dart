import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_animated_app/common/widgets/lighted_background.dart';
import 'package:smart_home_animated_app/common/widgets/page_indicators.dart';
import 'package:smart_home_animated_app/common/widgets/sh_app_bar.dart';
import 'package:smart_home_animated_app/controller/home_controller.dart';
import 'package:smart_home_animated_app/pages/home/widgets/sm_home_bottom_navigation.dart';
import 'package:smart_home_animated_app/pages/home/widgets/smart_home_page_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.put(HomeController());
  final controller = PageController(viewportFraction: 0.8);

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      _homeController.currentPage.value = controller.page ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LightedBackgound(
      child: Scaffold(
        appBar: const ShAppBar(),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text("SELECT A ROOM",
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    SmartRoomsPageView(
                      controller: controller,
                    ),
                    const Positioned.fill(
                      top: null,
                      child: Column(
                        children: [
                          PageIndicators(),
                          SmHomeBottomNavigationBar(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
