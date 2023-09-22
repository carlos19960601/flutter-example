import 'package:flutter/material.dart';

class HeaderControl extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<StatefulWidget> createState() => _HeaderControlState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _HeaderControlState extends State<HeaderControl> {
  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
}
