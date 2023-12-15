import 'package:apidash/common/widgets/request_widgets.dart';
import 'package:flutter/material.dart';

class EditRequestPane extends StatefulWidget {
  const EditRequestPane({super.key});

  @override
  State<EditRequestPane> createState() => _EditRequestPaneState();
}

class _EditRequestPaneState extends State<EditRequestPane> {
  @override
  Widget build(BuildContext context) {
    return const RequestPane(
      codePaneVisible: false,
      children: [],
    );
  }
}
