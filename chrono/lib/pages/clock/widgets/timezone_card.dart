import 'package:chrono/models/clock/city.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class TimeZoneCard extends StatelessWidget {
  const TimeZoneCard({
    super.key,
    required this.city,
  });

  final City city;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 8.0, bottom: 8.0, right: 8.0),
            child: Column(
              children: [
                const SizedBox(height: 4),
                Text(
                  city.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 12.0),
          child: Column(
            children: [
              TimerBuilder.periodic(
                const Duration(seconds: 1),
                builder: (BuildContext context) {
                  return const Text("data");
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
