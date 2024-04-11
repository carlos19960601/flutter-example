import 'package:flutter/material.dart';
import 'package:taskez/core/app_color.dart';

class DarkRadialBackground extends StatelessWidget {
  DarkRadialBackground({
    super.key,
    required this.color,
  });

  final Color color;

  var list = List.generate(3, (index) => HexColor.fromHex("1D192D"));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              ...list,
              color,
            ],
          ),
        ),
      ),
    );
  }
}
