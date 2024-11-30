import 'package:chrono/core/app_extension.dart';
import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.child,
    this.onTap,
    this.color,
  });

  final Widget child;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: getCardDecoration(
        context,
        color: color ?? context.surface,
      ),
      child: onTap == null
          ? child
          : InkWell(
              onTap: onTap,
              child: child,
            ),
    );
  }

  BoxDecoration getCardDecoration(
    BuildContext context, {
    Color? color,
    showShadow = true,
    boxShape = BoxShape.rectangle,
  }) {
    return BoxDecoration(
      color: color ?? context.surface,
      borderRadius: boxShape == BoxShape.rectangle
          ? context.cardTheme.shape != null
              ? (context.cardTheme.shape as RoundedRectangleBorder).borderRadius
              : const BorderRadius.all(Radius.circular(8))
          : null,
      shape: boxShape,
      boxShadow: [
        if (showShadow)
          BoxShadow(
            color: context.colorScheme.shadow,
          ),
      ],
    );
  }
}
