import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget homeDrawer({
  required BuildContext context,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
}) {
  return Padding(
    padding: padding,
    child: Transform.rotate(
      angle: 22 ,
      child: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(
          Icons.horizontal_split_rounded,
        ),
      ),
    ),
  );
}
