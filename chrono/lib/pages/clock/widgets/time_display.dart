import 'package:chrono/core/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimeDisplay extends StatelessWidget {
  const TimeDisplay(
      {super.key, required this.format, required this.dateTime, this.color});

  final DateTime dateTime;
  final String format;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Locale locale = Get.locale!;
    String formattedTime =
        DateFormat(format, locale.languageCode).format(dateTime);
    return Text(
      formattedTime,
      style: context.displaySmall!.copyWith(
        color: color,
      ),
    );
  }
}
