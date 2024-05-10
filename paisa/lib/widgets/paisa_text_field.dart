import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaisaTextFormField extends StatelessWidget {
  const PaisaTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.none,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.maxLength,
    this.maxLines,
    this.label,
    this.inputFormatters,
    this.counterText,
    this.textCapitalization = TextCapitalization.sentences,
  });

  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final String? counterText;
  final bool? enabled;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final String? label;
  final int? maxLength;
  final int? maxLines;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      maxLines: maxLength,
      enabled: enabled,
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        counterText: "",
        hintText: hintText,
        label: label != null ? Text(label!) : null,
      ),
      validator: validator,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
    );
  }
}
