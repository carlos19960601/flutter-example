import 'package:flutter/material.dart';

class TextFont extends StatelessWidget {
  const TextFont({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return textWidget(context, text);
  }

  Widget textWidget(BuildContext context, String text) {
    final TextStyle textStyle = TextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: Colors.black,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.double,
      decorationColor: Colors.white,
      overflow: overflow,
    );

    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 200),
      style: textStyle,
      child: Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.ellipsis,
        style: textStyle,
      ),
    );
  }
}
