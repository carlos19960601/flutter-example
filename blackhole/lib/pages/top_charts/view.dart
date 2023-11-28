import 'package:flutter/material.dart';

class TopCharts extends StatefulWidget {
  const TopCharts({super.key, required this.pageController});

  final PageController pageController;
  @override
  State<TopCharts> createState() => _TopChartsState();
}

class _TopChartsState extends State<TopCharts> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(),
    );
  }
}
