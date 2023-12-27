import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Material(
        type: MaterialType.transparency,
        child: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.line_horizontal_3),
        ),
      ),
      actions: [
        Material(
          type: MaterialType.transparency,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.search),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
