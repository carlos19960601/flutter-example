import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.items,
    this.currentIndex = 0,
  });

  final List<CustomBottomNavBarItem> items;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          for (final CustomBottomNavBarItem item in items)
            Material(
              child: InkWell(
                child: Row(
                  children: [
                    IconTheme(
                      data: const IconThemeData(
                        size: 24,
                      ),
                      child: items.indexOf(item) == currentIndex
                          ? item.activeIcon ?? item.icon
                          : item.icon,
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}

class CustomBottomNavBarItem {
  CustomBottomNavBarItem({
    required this.icon,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
    this.activeIcon,
  });

  final Widget icon;
  final Widget? activeIcon;
  final Widget title;
  final Color? selectedColor;
  final Color? unselectedColor;
}
