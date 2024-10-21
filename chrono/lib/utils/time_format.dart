import 'package:chrono/models/clock/time.dart';
import 'package:flutter/material.dart';

String getTimeFormatString(BuildContext context, TimeFormat timeFormat,
    {String separator = "default"}) {
  if (separator == "default") {
    separator = ":";
  }

  return timeFormat == TimeFormat.h12 ? "h${separator}mm" : "HH${separator}mm";
}
