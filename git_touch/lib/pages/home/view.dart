import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:git_touch/models/auth.dart';
import 'package:git_touch/pages/home/controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Created 5 different variables instead of a list as list doesn't work
  final GlobalKey<NavigatorState> tab1 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> tab2 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> tab3 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> tab4 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> tab5 = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> getNavigatorKey(int index) {
    switch (index) {
      case 0:
        return tab1;
      case 1:
        return tab2;
      case 2:
        return tab3;
      case 3:
        return tab4;
      case 4:
        return tab5;
    }
    return tab1;
  }

  List<BottomNavigationBarItem> _buildNavigationItems() {
    final platform = _homeController.auth.activeAccount!.platform;
    switch (platform) {
      case PlatformType.github:
        return [
          const BottomNavigationBarItem(
            icon: Icon(Ionicons.newspaper_outline),
          )
        ];
      default:
        return [];
    }
  }

  late HomeController _homeController;

  @override
  void initState() {
    super.initState();
    _homeController = Get.put(HomeController())
  }

  @override
  Widget build(BuildContext context) {
    final auth = _homeController.auth;
    if (auth.activeAccount == null) {
      return LoginPage();
    }

    return PopScope(
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: _buildNavigationItems()),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            navigatorKey: getNavigatorKey(index),
          );
        },
      ),
    );
  }
}
