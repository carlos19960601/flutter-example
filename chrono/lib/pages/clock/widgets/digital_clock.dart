import 'package:chrono/pages/clock/widgets/digital_clock_display.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class DigitalClock extends StatelessWidget {
  const DigitalClock({super.key});

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(
      const Duration(seconds: 1),
      builder: (BuildContext context) {
        DateTime dateTime = DateTime.now();
        return DigitalClockDisplay(dateTime: dateTime);
      },
    );
  }
}
