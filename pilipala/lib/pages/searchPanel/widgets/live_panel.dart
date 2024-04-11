import 'package:flutter/material.dart';

Widget searchLivePanel(BuildContext context, ctr, list) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    itemBuilder: (context, index) {
      return LiveItem(liveItem: list![index]);
    },
  );
}

class LiveItem extends StatelessWidget {
  final dynamic liveItem;
  const LiveItem({super.key, required this.liveItem});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
