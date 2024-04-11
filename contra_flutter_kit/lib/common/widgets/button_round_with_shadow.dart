import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonRoundWithShadow extends StatelessWidget {
  const ButtonRoundWithShadow({
    super.key,
    required this.borderColor,
    required this.shadowColor,
    required this.color,
    required this.iconPath,
    required this.size,
    required this.callback,
  });

  final Color borderColor;
  final Color shadowColor;
  final Color color;
  final String iconPath;
  final VoidCallback callback;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: size,
        width: size,
        padding: const EdgeInsets.all(8),
        decoration: ShapeDecoration(
          color: color,
          shadows: [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(0, 4),
            )
          ],
          shape: CircleBorder(
              side: BorderSide(
            color: borderColor,
            width: 2,
          )),
        ),
        child: SvgPicture.asset(iconPath),
      ),
    );
  }
}
