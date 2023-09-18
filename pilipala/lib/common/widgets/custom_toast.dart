import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  final String msg;
  const CustomToast({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        msg,
        style: TextStyle(
          fontSize: 13,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
