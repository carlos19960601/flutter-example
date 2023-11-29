import 'package:flutter/material.dart';
import 'package:flutter_unit/common/toly_icon.dart';
import 'package:flutter_unit/pages/collect/view.dart';
import 'package:flutter_unit/pages/home/view.dart';
import 'package:flutter_unit/pages/user/view.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  List<String> bottomBar = ['组件', '收藏', '我的'];
  List<IconData> get bottomBarIcon => const [
        TolyIcon.icon_layout,
        TolyIcon.icon_collect,
        TolyIcon.yonghu,
      ];

  int _currentIndex = 0;

  final PageController _pageController = PageController();

  Widget _buildBottomNav(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
            onTap: (int value) {
              _currentIndex = value;
              setState(() {});
            },
            iconSize: 22,
            currentIndex: _currentIndex,
            selectedItemColor: Theme.of(context).primaryColor,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: bottomBar
                .asMap()
                .keys
                .map(
                  (index) => BottomNavigationBarItem(
                    label: bottomBar[index],
                    icon: Icon(bottomBarIcon[index]),
                  ),
                )
                .toList())
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          HomePage(),
          CollectPage(),
          UserPage(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }
}
