import 'package:chrono/core/app_extension.dart';
import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getCardDecoration(context),
      child: child,
    );
  }

  BoxDecoration getCardDecoration(
    BuildContext context, {
    showShadow = true,
  }) {
    return BoxDecoration(
      boxShadow: [
        if (showShadow)
          BoxShadow(
            color: context.colorScheme.shadow,
          ),
      ],
    );
  }
}
