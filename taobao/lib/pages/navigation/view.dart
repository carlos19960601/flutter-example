import 'package:flutter/material.dart';
import 'package:taobao/core/app_icon.dart';

class GZXBottomNavigationBar extends StatefulWidget {
  const GZXBottomNavigationBar({super.key});

  @override
  State<GZXBottomNavigationBar> createState() => _GZXBottomNavigationBarState();
}

class _GZXBottomNavigationBarState extends State<GZXBottomNavigationBar> {
  final PageController pageController = PageController(initialPage: 0);
  final _bottomNavigationColor = const Color(0xFF585858);
  final Color _bottomNavigationActiveColor = Colors.blue;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          pageController.jumpToPage(value);
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              AppIcon.home,
              color: _currentIndex == 0
                  ? _bottomNavigationActiveColor
                  : _bottomNavigationColor,
            ),
            activeIcon: Icon(
              AppIcon.home_active,
              color: _currentIndex == 0
                  ? _bottomNavigationActiveColor
                  : _bottomNavigationColor,
              size: 34,
            ),
          ),
        ],
      ),
    );
  }
}
