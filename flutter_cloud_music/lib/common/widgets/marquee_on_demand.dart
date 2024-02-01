import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarqueeOnDemand extends StatelessWidget {
  const MarqueeOnDemand({
    super.key,
    required this.text,
    required this.textStyle,
  });

  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    final textWidth = _textSize(text, textStyle).width;
    return textWidth < switchWidth
        ? textBuilder(context, text, textStyle)
        : marqueeBuilder(context, text, textStyle);
  }

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(
        minWidth: 0,
        maxWidth: double.infinity,
      );

    return textPainter.size;
  }
}
