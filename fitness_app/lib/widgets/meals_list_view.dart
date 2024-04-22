import 'package:flutter/material.dart';

class MealsListView extends StatefulWidget {
  const MealsListView(
      {super.key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation});

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  State<MealsListView> createState() => _MealsListViewState();
}

class _MealsListViewState extends State<MealsListView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
