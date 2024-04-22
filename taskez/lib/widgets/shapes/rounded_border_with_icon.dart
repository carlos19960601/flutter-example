import 'package:flutter/material.dart';
import 'package:taskez/core/app_color.dart';

class RoundedBorderWithIcon extends StatelessWidget {
  const RoundedBorderWithIcon({
    super.key,
    required this.icon,
    this.width = 30,
    this.height = 30,
  });

  final IconData icon;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 3,
          color: HexColor.fromHex("31333D"),
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
