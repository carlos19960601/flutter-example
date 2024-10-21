import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class AnalogClock extends StatelessWidget {
  const AnalogClock({super.key});

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(
      const Duration(seconds: 1),
      builder: (BuildContext context) {
        return const Column(
          children: [],
        );
      },
    );
  }
}
