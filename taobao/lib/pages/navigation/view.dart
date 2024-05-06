import 'package:flutter/material.dart';
import 'package:taobao/core/app_icon.dart';
import 'package:taobao/pages/home/view.dart';

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
        children: const [
          HomeScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          pageController.jumpToPage(value);
          setState(() {
            _currentIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _bottomNavigationActiveColor,
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
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              AppIcon.we_tao,
              color: _currentIndex == 1
                  ? _bottomNavigationActiveColor
                  : _bottomNavigationColor,
            ),
            activeIcon: Icon(
              AppIcon.we_tao_fill,
              color: _currentIndex == 1
                  ? _bottomNavigationActiveColor
                  : _bottomNavigationColor,
              size: 34,
            ),
            label: '微淘',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              AppIcon.message,
              color: _currentIndex == 2
                  ? _bottomNavigationActiveColor
                  : _bottomNavigationColor,
            ),
            activeIcon: Icon(
              AppIcon.message_fill,
              color: _currentIndex == 2
                  ? _bottomNavigationActiveColor
                  : _bottomNavigationColor,
              size: 34,
            ),
            label: '消息',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              AppIcon.cart,
              color: _currentIndex == 3
                  ? _bottomNavigationActiveColor
                  : _bottomNavigationColor,
            ),
            activeIcon: Icon(
              AppIcon.cart_fill,
              color: _currentIndex == 3
                  ? _bottomNavigationActiveColor
                  : _bottomNavigationColor,
              size: 34,
            ),
            label: '购物车',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              AppIcon.my,
              color: _currentIndex == 4
                  ? _bottomNavigationActiveColor
                  : _bottomNavigationColor,
            ),
            activeIcon: Icon(
              AppIcon.my_fill,
              color: _currentIndex == 4
                  ? _bottomNavigationActiveColor
                  : _bottomNavigationColor,
              size: 34,
            ),
            label: '我的淘宝',
          ),
        ],
      ),
    );
  }
}
