import 'package:flutter/material.dart';
import 'package:paisa/core/app_extensions.dart';

class IntroTextWidget extends StatelessWidget {
  const IntroTextWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        Icons.check_circle,
        color: context.primary,
      ),
      dense: true,
      title: Text(
        title,
        style: context.titleMedium,
      ),
    );
  }
}
