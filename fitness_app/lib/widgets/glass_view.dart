import 'package:flutter/material.dart';

class GlassView extends StatelessWidget {
  const GlassView({
    super.key,
    this.animationController,
    this.animation,
  });

  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
