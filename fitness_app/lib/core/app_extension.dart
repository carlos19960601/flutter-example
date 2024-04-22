import 'package:fitness_app/widgets/fade_in_animation.dart';
import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget fadeAnimation(double delay) {
    return FadeInAnimation(delay: delay, child: this);
  }
}
