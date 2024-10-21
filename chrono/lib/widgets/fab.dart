import 'package:chrono/core/app_extension.dart';
import 'package:chrono/core/app_icon.dart';
import 'package:chrono/widgets/card_container.dart';
import 'package:flutter/material.dart';

enum FabPosition { bottomLeft, bottomRight }

class FAB extends StatefulWidget {
  const FAB({
    super.key,
    this.icon = FluxIcons.add,
    this.bottomPadding = 0,
    this.position = FabPosition.bottomRight,
  });

  final IconData icon;
  final double bottomPadding;
  final FabPosition position;

  @override
  State<FAB> createState() => _FABState();
}

class _FABState extends State<FAB> {
  @override
  Widget build(BuildContext context) {
    double bottomPadding = widget.bottomPadding + 20;
    return Positioned(
      bottom: bottomPadding,
      right: widget.position == FabPosition.bottomRight ? 10 : null,
      child: CardContainer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            widget.icon,
            color: context.onPrimary,
          ),
        ),
      ),
    );
  }
}
