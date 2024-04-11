import 'package:flutter/material.dart';

class CircleDotWidget extends StatelessWidget {
  const CircleDotWidget({
    super.key,
    required this.isActive,
    required this.color,
    required this.borderColor,
  });

  final bool isActive;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      width: isActive ? 14 : 10,
      height: isActive ? 14 : 10,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          width: 2,
          color: borderColor,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
