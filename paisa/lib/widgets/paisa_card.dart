import 'package:flutter/material.dart';

class PaisaFilledCard extends StatelessWidget {
  const PaisaFilledCard({
    super.key,
    required this.child,
    this.shape,
    this.color,
  });

  final Widget child;
  final Color? color;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
      elevation: 0,
      child: child,
    );
  }
}
