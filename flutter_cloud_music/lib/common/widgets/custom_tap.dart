import 'package:flutter/material.dart';

class Bounce extends StatefulWidget {
  const Bounce({
    super.key,
    required this.onPressed,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
    this.scaleFactor = 1.25,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Duration duration;
  final double scaleFactor;

  @override
  State<Bounce> createState() => _BounceState();
}

class _BounceState extends State<Bounce> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: widget.child,
    );
  }

  _onTap() {
    widget.onPressed();
  }
}
