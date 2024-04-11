import 'package:apidash/consts.dart';
import 'package:flutter/material.dart';

class URLField extends StatefulWidget {
  const URLField({
    super.key,
    required this.activeId,
    this.initialValue,
    this.onChanged,
  });

  final String activeId;
  final String? initialValue;
  final void Function(String)? onChanged;

  @override
  State<URLField> createState() => _URLFieldState();
}

class _URLFieldState extends State<URLField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key("url-${widget.activeId}"),
      initialValue: widget.initialValue,
      style: kCodeStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: kHintTextUrlCard,
        hintStyle: kCodeStyle.copyWith(
          color:
              Theme.of(context).colorScheme.outline.withOpacity(kHintOpacity),
        ),
      ),
      onChanged: widget.onChanged,
    );
  }
}
