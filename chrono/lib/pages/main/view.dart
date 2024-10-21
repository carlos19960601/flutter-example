import 'package:chrono/core/app_extension.dart';
import 'package:chrono/core/app_icon.dart';
import 'package:chrono/models/common/tab_type.dart';
import 'package:chrono/pages/main/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Obx(
              () => Text(
                tabsConfig[mainController.currentIndex.value].label,
                style: context.titleMedium!.copyWith(
                  color: context.onBackground.withOpacity(0.5),
                ),
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FluxIcons.settings,
            ),
            color: context.onBackground.withOpacity(0.8),
          )
        ],
      ),
      body: SafeArea(
        child: PageView(
          controller: mainController.pageController,
          onPageChanged: mainController.onPageChanged,
          children: tabsConfig.map((tabConfig) => tabConfig.page).toList(),
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: mainController.currentIndex.value,
          destinations: [
            for (final tabConfig in tabsConfig)
              NavigationDestination(
                icon: Icon(tabConfig.icon),
                label: tabConfig.label,
              ),
          ],
          onDestinationSelected: mainController.onDestinationSelected,
        ),
      ),
    );
  }
}
