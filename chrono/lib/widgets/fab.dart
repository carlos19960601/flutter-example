import 'package:chrono/core/app_extension.dart';
import 'package:chrono/core/app_icon.dart';
import 'package:chrono/widgets/card_container.dart';
import 'package:flutter/material.dart';

enum FabPosition { bottomLeft, bottomRight }

class FAB extends StatefulWidget {
  const FAB({
    super.key,
    this.onPressed,
    this.icon = FluxIcons.add,
    this.bottomPadding = 0,
    this.size = 1,
    this.position = FabPosition.bottomRight,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final double bottomPadding;
  final FabPosition position;
  final double size;

  @override
  State<FAB> createState() => _FABState();
}

class _FABState extends State<FAB> {
  @override
  Widget build(BuildContext context) {
    double bottomPadding = widget.bottomPadding + 20;
    return Positioned(
      bottom: bottomPadding,
      right: widget.position == FabPosition.bottomRight ? 16 : null,
      left: widget.position == FabPosition.bottomLeft ? 16 : null,
      child: CardContainer(
        color: context.primary,
        onTap: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            widget.icon,
            color: context.onPrimary,
            size: 24 * widget.size,
          ),
        ),
      ),
    );
  }
}
