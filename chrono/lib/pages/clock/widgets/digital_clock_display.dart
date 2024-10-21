import 'package:chrono/core/app_extension.dart';
import 'package:chrono/core/app_storage.dart';
import 'package:chrono/models/clock/time.dart';
import 'package:chrono/pages/clock/widgets/time_display.dart';
import 'package:chrono/utils/time_format.dart';
import 'package:flutter/material.dart';

class DigitalClockDisplay extends StatefulWidget {
  const DigitalClockDisplay({
    super.key,
    required this.dateTime,
    this.shouldShowTime = true,
    this.shouldShowDate = false,
  });

  final DateTime dateTime;
  final bool shouldShowTime;
  final bool shouldShowDate;

  @override
  State<DigitalClockDisplay> createState() => _DigitalClockDisplayState();
}

class _DigitalClockDisplayState extends State<DigitalClockDisplay> {
  TimeFormat getTimeFormat() {
    TimeFormat timeFormat = AppStorage().timeFormat;
    if (timeFormat == TimeFormat.device) {
      if (context.alwaysUse24HourFormat) {
        timeFormat = TimeFormat.h24;
      } else {
        timeFormat = TimeFormat.h12;
      }
    }

    return timeFormat;
  }

  @override
  Widget build(BuildContext context) {
    TimeFormat timeFormat = getTimeFormat();

    return Column(
      children: [
        if (widget.shouldShowTime)
          Row(
            children: [
              TimeDisplay(
                format: getTimeFormatString(context, timeFormat),
                dateTime: widget.dateTime,
              ),
            ],
          )
      ],
    );
  }
}
