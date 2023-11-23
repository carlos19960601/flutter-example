import 'package:flutter/material.dart';

class TextFont extends StatelessWidget {
  const TextFont({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return textWidget(text);
  }

  Widget textWidget(String text) {
    return Text(
      text,
    );
  }
}
