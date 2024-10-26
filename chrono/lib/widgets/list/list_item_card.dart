import 'package:chrono/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ListItemCard<T> extends StatefulWidget {
  const ListItemCard({super.key, required this.child});

  final Widget child;

  @override
  State<ListItemCard> createState() => _ListItemCardState();
}

class _ListItemCardState<T> extends State<ListItemCard> {
  @override
  Widget build(BuildContext context) {
    Widget innerWidget = widget.child;
    return CardContainer(
      child: Row(
        children: [
          AnimatedContainer(
            duration: 150.ms,
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 16.0, bottom: 16.0),
              child: Icon(Icons.drag_indicator),
            ),
          ),
          Expanded(child: innerWidget),
        ],
      ),
    );
  }
}
