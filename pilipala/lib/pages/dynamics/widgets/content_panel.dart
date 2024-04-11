import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  dynamic item;
  String? source;

  Content({super.key, this.item, this.source});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    TextStyle authorStyle =
        TextStyle(color: Theme.of(context).colorScheme.primary);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.item.modules.moduleDynamic.topic != null) ...[
            GestureDetector(
              child: Text(
                '#${widget.item.modules.moduleDynamic.topic.name}',
                style: authorStyle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
