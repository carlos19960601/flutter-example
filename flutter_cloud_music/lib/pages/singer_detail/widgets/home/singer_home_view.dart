import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/singer_detail/controller.dart';
import 'package:flutter_cloud_music/pages/singer_detail/state.dart';

class SingerHomeView extends StatelessWidget {
  const SingerHomeView({
    super.key,
    required this.state,
    required this.controller,
  });

  final SingerDetailState state;
  final SingerDetailController controller;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
