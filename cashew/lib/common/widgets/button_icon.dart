import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  const ButtonIcon({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 44,
    this.color,
    this.iconColor,
    this.iconPadding = 20,
    this.padding,
  });

  final IconData icon;
  final double size;
  final Color? color;
  final Color? iconColor;
  final EdgeInsets? padding;
  final double iconPadding;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        margin: padding,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Icon(
          icon,
          color:
              iconColor ?? Theme.of(context).colorScheme.onSecondaryContainer,
          size: size - iconPadding,
        ),
      ),
    );
  }
}
