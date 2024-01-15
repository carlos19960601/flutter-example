import 'package:flutter/cupertino.dart';

class SingleScaffold extends StatelessWidget {
  const SingleScaffold({
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
    return const Placeholder();
  }
}
