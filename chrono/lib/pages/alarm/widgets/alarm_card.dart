import 'package:chrono/models/alarm/alarm.dart';
import 'package:flutter/material.dart';

class AlarmCard extends StatefulWidget {
  const AlarmCard({super.key, required this.alarm});

  final Alarm alarm;

  @override
  State<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(children: [],),
            ),
          ),
          Column(
            children: [],
          )
        ],
      ),
    );
  }
}
