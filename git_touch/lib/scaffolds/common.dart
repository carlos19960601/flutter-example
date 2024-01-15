import 'package:flutter/cupertino.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    super.key,
    required this.title,
    required this.body,
    this.action,
  });

  final Widget title;
  final Widget body;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: body,
      ),
    );
  }
}
