import 'package:apidash/consts.dart';
import 'package:flutter/material.dart';

class TabLabel extends StatelessWidget {
  const TabLabel({
    super.key,
    required this.text,
    this.showIndicator = false,
  });

  final String text;
  final bool showIndicator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kTabHeight,
      child: Stack(
        children: [
          Center(
            child: Text(text),
          ),
          if (showIndicator)
            const Align(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 6,
                ),
                child: Icon(
                  Icons.circle,
                  size: 6,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
