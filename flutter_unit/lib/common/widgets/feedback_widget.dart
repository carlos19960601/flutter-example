import 'dart:math';

import 'package:flutter/material.dart';

enum FeedMode {
  scale,
  fade,
  rotate,
}

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({
    super.key,
    required this.child,
    this.onPressed,
    this.mode = FeedMode.fade,
    this.a = 0.9,
    this.duration = const Duration(milliseconds: 150),
  });

  final Function()? onPressed;
  final Widget child;
  final FeedMode mode;
  final double a;
  final Duration duration;

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed?.call();
      },
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => _buildByMode(child, widget.mode)),
    );
  }

  Widget _buildByMode(Widget? child, FeedMode mode) {
    double rate = (widget.a - 1) * _controller.value + 1;

    switch (mode) {
      case FeedMode.scale:
        return Transform.scale();
      case FeedMode.fade:
        return Opacity(
          opacity: rate,
          child: widget.child,
        );
      case FeedMode.rotate:
        return Transform.rotate(
          angle: rate * pi * 2,
          child: widget.child,
        );
    }
  }
}
