import 'package:chrono/core/app_icon.dart';
import 'package:chrono/pages/alarm/view.dart';
import 'package:chrono/pages/clock/view.dart';
import 'package:chrono/pages/stopwatch/view.dart';
import 'package:chrono/pages/timer/view.dart';
import 'package:flutter/material.dart';

class TabConfig {
  final String label;
  final IconData icon;
  final Widget page;

  TabConfig({
    required this.label,
    required this.icon,
    required this.page,
  });
}

List<TabConfig> tabsConfig = [
  TabConfig(label: "Alarm", icon: FluxIcons.alarm, page: const AlarmPage()),
  TabConfig(label: "Clock", icon: FluxIcons.clock, page: const ClockPage()),
  TabConfig(label: "Timer", icon: FluxIcons.timer, page: const TimerPage()),
  TabConfig(
    label: "Stopwatch",
    icon: FluxIcons.stopwatch,
    page: const StopwatchPage(),
  ),
];
