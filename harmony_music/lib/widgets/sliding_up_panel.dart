import 'package:flutter/material.dart';

class SlidingUpPanel extends StatefulWidget {
  const SlidingUpPanel({super.key});

  @override
  State<SlidingUpPanel> createState() => _SlidingUpPanelState();
}

class _SlidingUpPanelState extends State<SlidingUpPanel> {
  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [Navigator()],
    );
  }
}
