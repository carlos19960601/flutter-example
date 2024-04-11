import 'package:flutter/material.dart';

class NewSettingsPage extends StatefulWidget {
  const NewSettingsPage({super.key, this.callback});

  final Function? callback;

  @override
  State<NewSettingsPage> createState() => _NewSettingsPageState();
}

class _NewSettingsPageState extends State<NewSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
