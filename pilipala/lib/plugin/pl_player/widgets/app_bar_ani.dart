import 'package:flutter/material.dart';

class AppBarAni extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget child;
  final AnimationController controller;
  final bool visible;
  final String? position;

  const AppBarAni({
    super.key,
    required this.child,
    required this.controller,
    required this.visible,
    this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: position == "top"
            ? const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[
                  Colors.transparent,
                  Colors.black54,
                ],
                tileMode: TileMode.mirror,
              )
            : const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.transparent,
                  Colors.black54,
                ],
                tileMode: TileMode.mirror,
              ),
      ),
      child: child,
    );
  }

  @override
  Size get preferredSize => child.preferredSize;
}
