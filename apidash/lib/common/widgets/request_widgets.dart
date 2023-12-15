import 'package:apidash/consts.dart';
import 'package:flutter/material.dart';

class RequestPane extends StatefulWidget {
  const RequestPane({
    super.key,
    required this.children,
    required this.codePaneVisible,
  });

  final List<Widget> children;
  final bool codePaneVisible;

  @override
  State<RequestPane> createState() => _RequestPaneState();
}

class _RequestPaneState extends State<RequestPane> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: kPh20v10,
          child: SizedBox(
            height: kHeaderHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Request",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                FilledButton.tonalIcon(
                  onPressed: () {},
                  icon: Icon(
                    widget.codePaneVisible
                        ? Icons.code_off_rounded
                        : Icons.code_rounded,
                  ),
                  label: SizedBox(
                    width: 75,
                    child: Text(
                        widget.codePaneVisible ? "Hide Code" : "View Code"),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
