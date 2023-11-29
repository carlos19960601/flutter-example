import 'package:blackhole/common/widgets/bottom_nav_bar.dart';
import 'package:blackhole/pages/home/home_screen.dart';
import 'package:blackhole/pages/library/view.dart';
import 'package:blackhole/pages/settings/view.dart';
import 'package:blackhole/pages/top_charts/view.dart';
import 'package:blackhole/pages/youtube/view.dart';
import 'package:blackhole/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:blackhole/localization/translation_keys.dart' as translation_keys;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box setting = GStorage.setting;
  late List<String> sectionsToShow;

  final PageController _pageController = PageController();
  final PersistentTabController _controller = PersistentTabController();

  @override
  void initState() {
    super.initState();
    sectionsToShow = setting.get(SettingBoxKey.sectionsToShow,
        defaultValue: ['Home', 'Top Charts', 'YouTube', 'Library']);
  }

  void callback() {}

  List<CustomBottomNavBarItem> _navBarItems(BuildContext context) {
    return sectionsToShow.map((section) {
      switch (section) {
        case "Home":
          return CustomBottomNavBarItem(
            icon: const Icon(Icons.home_rounded),
            title: const Text(translation_keys.home.tr),
          );
        default:
          return CustomBottomNavBarItem(
            icon: const Icon(Icons.settings_rounded),
            title: const Text(translation_keys.settings.tr),
          );
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: PersistentTabView.custom(
              context,
              controller: _controller,
              customWidget: (NavBarEssentials essentials) {
                return Column(
                  children: [
                    CustomBottomNavBar(
                      items: _navBarItems(context),
                    )
                  ],
                );
              },
              itemCount: sectionsToShow.length,
              handleAndroidBackButtonPress: true,
              screens: sectionsToShow.map(
                (String e) {
                  switch (e) {
                    case "Home":
                      return const HomeScreen();
                    case 'Top Charts':
                      return TopCharts(
                        pageController: _pageController,
                      );
                    case 'YouTube':
                      return const YouTube();
                    case 'Library':
                      return const LibraryPage();
                    default:
                      return NewSettingsPage(callback: callback);
                  }
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
