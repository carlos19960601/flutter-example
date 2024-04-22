import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AniProps { opacity, translateY }

class FadeInAnimation extends StatelessWidget {
  const FadeInAnimation({
    super.key,
    required this.delay,
    required this.child,
  });

  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(AniProps.opacity, Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 500))
      ..tween(AniProps.translateY, Tween<double>(begin: 30.0, end: 0.0),
          duration: const Duration(milliseconds: 500), curve: Curves.easeOut);

    return PlayAnimationBuilder(
      delay: Duration(milliseconds: (500 * delay).round()),
      tween: tween,
      duration: tween.duration,
      child: child,
      builder: (context, Movie value, Widget? child) {
        return Opacity(
          opacity: value.get<double>(AniProps.opacity),
          child: Transform.translate(
            offset: Offset(0, value.get<double>(AniProps.translateY)),
            child: child,
          ),
        );
      },
    );
  }
}
