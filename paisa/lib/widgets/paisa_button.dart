import 'package:flutter/material.dart';
import 'package:paisa/core/app_extensions.dart';

class PaisaBigButton extends StatelessWidget {
  const PaisaBigButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        foregroundColor: context.onPrimary,
        backgroundColor: context.primary,
      ),
      child: Text(
        title,
        style: context.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: context.onPrimary,
        ),
      ),
    );
  }
}
