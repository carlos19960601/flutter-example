import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.duration = const Duration(milliseconds: 500),
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.curve = Curves.easeOutQuint,
    this.itemShape = const StadiumBorder(),
    this.onTap,
  });

  final Duration duration;
  final EdgeInsets itemPadding;
  final List<CustomBottomNavBarItem> items;
  final int currentIndex;
  final Color? backgroundColor;
  final Curve curve;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final ShapeBorder itemShape;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: items.length <= 2
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.spaceBetween,
        children: [
          for (final CustomBottomNavBarItem item in items)
            TweenAnimationBuilder<double>(
              tween: Tween(
                end: items.indexOf(item) == currentIndex ? 1.0 : 0.0,
              ),
              duration: duration,
              builder: (BuildContext context, double t, Widget? child) {
                final Color selectedColor = item.selectedColor ??
                    selectedItemColor ??
                    theme.primaryColor;
                final Color unselectedColor = item.unselectedColor ??
                    unselectedItemColor ??
                    theme.iconTheme.color!;

                return Material(
                  color: Color.lerp(
                    selectedColor.withOpacity(0.0),
                    selectedColor.withOpacity(0.1),
                    t,
                  ),
                  shape: itemShape,
                  child: InkWell(
                    onTap: () => onTap?.call(items.indexOf(item)),
                    customBorder: itemShape,
                    child: Padding(
                      padding: itemPadding -
                          EdgeInsets.only(right: itemPadding.right * t),
                      child: Row(
                        children: [
                          IconTheme(
                            data: IconThemeData(
                              size: 24,
                              color:
                                  Color.lerp(unselectedColor, selectedColor, t),
                            ),
                            child: items.indexOf(item) == currentIndex
                                ? item.activeIcon ?? item.icon
                                : item.icon,
                          ),
                          ClipRect(
                            clipBehavior: Clip.antiAlias,
                            child: SizedBox(
                              height: 20,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: itemPadding.left / 2,
                                  right: itemPadding.right,
                                ),
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    color: Color.lerp(
                                      selectedColor.withOpacity(0),
                                      selectedColor,
                                      t,
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  child: item.title,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
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
