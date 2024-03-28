import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  const CheckBox({
    super.key,
    this.colorSchema,
    required this.value,
    required this.onChanged,
  });

  final ColorScheme? colorSchema;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    var colorSchema = this.colorSchema ?? Theme.of(context).colorScheme;
    return Checkbox(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3), // 设置圆角
      ),
      side: BorderSide(
        width: 1.5,
        color: colorSchema.surfaceVariant,
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
