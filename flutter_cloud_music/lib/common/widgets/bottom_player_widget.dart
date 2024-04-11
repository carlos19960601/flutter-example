import 'package:flutter/material.dart';

class BottomPlayerController extends StatelessWidget {
  const BottomPlayerController({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: child),
      ],
    );
  }
}
