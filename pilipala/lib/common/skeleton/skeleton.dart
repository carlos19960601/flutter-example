import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  final Widget child;
  const Skeleton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var shimmerGradient = LinearGradient(colors: [
      Colors.transparent,
      Theme.of(context).colorScheme.background.withAlpha(10),
      Theme.of(context).colorScheme.background.withAlpha(10),
      Colors.transparent,
    ]);
    return Shimmer(linearGradient: shimmerGradient);
  }
}

class Shimmer extends StatefulWidget {
  final Widget? child;
  final LinearGradient linearGradient;

  const Shimmer({super.key, required this.linearGradient, this.child});

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> {
  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}
