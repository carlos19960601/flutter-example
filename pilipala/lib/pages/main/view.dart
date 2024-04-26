import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/models/common/dynamic_badge_mode.dart';
import 'package:pilipala/pages/dynamics/controller.dart';
import 'package:pilipala/pages/home/controller.dart';
import 'package:pilipala/pages/main/controller.dart';
import 'package:pilipala/pages/media/controller.dart';
import 'package:pilipala/pages/rank/controller.dart';
import 'package:pilipala/utils/storage.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final MainController _mainController = Get.put(MainController());
  final HomeController _homeController = Get.put(HomeController());
  final RankController _rankController = Get.put(RankController());
  final DynamicsController _dynamicsController = Get.put(DynamicsController());
  final MediaController _mediaController = Get.put(MediaController());

  int? _lastSelectTime; //上次点击时间
  Box setting = GStorage.setting;
  late bool enableMYBar;

  @override
  void initState() {
    super.initState();
    _lastSelectTime = DateTime.now().millisecondsSinceEpoch;
    _mainController.pageController =
        PageController(initialPage: _mainController.selectedIndex);
    enableMYBar = setting.get(SettingBoxKey.enableMYBar, defaultValue: true);
  }

  @override
  void dispose() async {
    await GStorage.close();
    super.dispose();
  }

  setIndex(int value) {
    _mainController.pageController.jumpToPage(value);
    var currentPage = _mainController.pages[value];
  }

  @override
  Widget build(BuildContext context) {
    Box localCache = GStorage.localCache;
    double statusBarHeight = Get.mediaQuery.padding.top;
    double sheetHeight = Get.mediaQuery.size.height -
        Get.mediaQuery.padding.top -
        Get.mediaQuery.size.width * 9 / 16;

    localCache.put("sheetHeight", sheetHeight);
    localCache.put('statusBarHeight', statusBarHeight);
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBody: true, // 会延伸body到bottomNavigationBar的位置
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _mainController.pageController,
          children: _mainController.pages,
          onPageChanged: (value) {
            _mainController.selectedIndex = value;
            setState(() {});
          },
        ),
        // Q: 为什么用 StreamBuilder, 和 setState 有什么区别？
        // A: StreamBuilder性能更好，setState回导致子树rebuild
        bottomNavigationBar: StreamBuilder(
          // 监听page的滚动，控制bottomNavigationBar的显示和隐藏
          stream: _mainController.bottomBarStream.stream,
          initialData: true,
          builder: (context, AsyncSnapshot snapshot) {
            return Obx(
              () => enableMYBar
                  ? AnimatedSlide(
                      curve: Curves.easeInOutCubicEmphasized,
                      offset: Offset(
                        0,
                        snapshot.data ? 0 : 1,
                      ), // 控制下面的导航菜单显示，dx，dy是相对child的大小的
                      duration: const Duration(milliseconds: 500),
                      child: NavigationBar(
                        selectedIndex: _mainController.selectedIndex,
                        onDestinationSelected: (value) => setIndex(value),
                        destinations: _mainController.navigationBars
                            .map(
                              (e) => NavigationDestination(
                                icon: Obx(
                                  () => Badge(
                                    label: _mainController
                                                .dynamicBadgeType.value ==
                                            DynamicBadgeMode.number
                                        ? Text(e["count"].toString())
                                        : null,
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 0, 6, 0),
                                    isLabelVisible: _mainController
                                                .dynamicBadgeType.value !=
                                            DynamicBadgeMode.hidden &&
                                        e["count"] > 0,
                                    child: e["icon"],
                                  ),
                                ),
                                label: e["label"],
                                selectedIcon: e["selectIcon"],
                              ),
                            )
                            .toList(),
                      ),
                    )
                  : BottomNavigationBar(
                      currentIndex: _mainController.selectedIndex,
                      onTap: (value) => setIndex(value),
                      iconSize: 25,
                      selectedFontSize: 12,
                      unselectedFontSize: 12,
                      items: _mainController.navigationBars.map(
                        (e) {
                          return BottomNavigationBarItem(
                            icon: Obx(
                              () => Badge(
                                label: _mainController.dynamicBadgeType.value ==
                                        DynamicBadgeMode.number
                                    ? Text(e['count'].toString())
                                    : null,
                                padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                                isLabelVisible:
                                    _mainController.dynamicBadgeType.value !=
                                            DynamicBadgeMode.hidden &&
                                        e['count'] > 0,
                                child: e["icon"],
                              ),
                            ),
                            activeIcon: e["selectedIcon"],
                            label: e["label"],
                          );
                        },
                      ).toList(),
                    ),
            );
          },
        ),
      ),
    );
  }
}
