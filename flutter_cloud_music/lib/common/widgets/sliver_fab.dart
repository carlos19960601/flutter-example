import 'package:flutter/material.dart';

class SliverFab extends StatefulWidget {
  const SliverFab({super.key, required this.slivers});

  final List<Widget> slivers;

  @override
  State<SliverFab> createState() => _SliverFabState();
}

class _SliverFabState extends State<SliverFab> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: widget.slivers,
        )
      ],
    );
  }
}
