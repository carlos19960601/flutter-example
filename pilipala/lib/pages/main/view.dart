import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/pages/main/controller.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final MainController _mainController = Get.put(MainController());

  PageController? _pageController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  setIndex(int value) {
    if (selectedIndex != value) {
      selectedIndex = value;
      setState(() {});
    }

    _pageController!.jumpToPage(value);
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return WillPopScope(
      child: Scaffold(
        extendBody: true,
        body: PageView(
          controller: _pageController,
          children: _mainController.pages,
          onPageChanged: (value) {
            selectedIndex = value;
            setState(() {});
          },
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (value) => setIndex(value),
          selectedIndex: selectedIndex,
          destinations: _mainController.navigationBars
              .map(
                (e) => NavigationDestination(
                  icon: e["icon"],
                  label: e["label"],
                  selectedIcon: e["selectIcon"],
                ),
              )
              .toList(),
        ),
      ),
      onWillPop: () async {
        return true;
      },
    );
  }
}
