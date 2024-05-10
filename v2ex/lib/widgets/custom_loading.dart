import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  const CustomToast({super.key, required this.msg});

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Text(
        msg,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
