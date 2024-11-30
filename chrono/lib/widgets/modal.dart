import 'package:chrono/core/app_extension.dart';
import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  const Modal({
    super.key,
    this.title,
    required this.child,
    this.onSave,
    this.isSaveEnabled = true,
  });

  final String? title;
  final Widget child;
  final VoidCallback? onSave;
  final bool isSaveEnabled;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null
          ? Text(
              title!,
              style: context.displaySmall?.copyWith(
                color: context.onBackground.withOpacity(0.6),
              ),
            )
          : null,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: child,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("取消")),
            TextButton(
              child: const Text("保存"),
              onPressed: () {
                if (isSaveEnabled) {
                  onSave?.call();
                }
              },
            )
          ],
        )
      ],
    );
  }
}
