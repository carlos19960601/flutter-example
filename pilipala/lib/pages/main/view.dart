import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/pages/dynamics/controller.dart';
import 'package:pilipala/pages/home/controller.dart';
import 'package:pilipala/pages/main/controller.dart';
import 'package:pilipala/utils/storage.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final MainController _mainController = Get.put(MainController());
  final DynamicsController _dynamicsController = Get.put(DynamicsController());
  final HomeController _homeController = Get.put(HomeController());

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
    Box localCache = GStorage.localCache;
    localCache.put('statusBarHeight', statusBarHeight);
    return PopScope(
      canPop: true,
      child: Scaffold(
        extendBody: true, // 会延伸body到bottomNavigationBar的位置
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: _mainController.pages,
          onPageChanged: (value) {
            selectedIndex = value;
            setState(() {});
          },
        ),
        // Q: 为什么用 StreamBuilder, 和 setState 有什么区别？
        // A: StreamBuilder性能更好，setState回导致子树rebuild
        bottomNavigationBar: StreamBuilder(
          stream: _mainController.bottomBarStream.stream,
          initialData: true,
          builder: (context, AsyncSnapshot snapshot) {
            return AnimatedSlide(
              curve: Curves.easeInOutCubicEmphasized,
              offset: Offset(
                0,
                snapshot.data ? 0 : 1,
              ), // 控制下面的导航菜单显示，dx，dy是相对child的大小的
              duration: const Duration(milliseconds: 500),
              child: NavigationBar(
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
            );
          },
        ),
      ),
    );
  }
}
