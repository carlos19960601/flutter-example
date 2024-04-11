import 'package:flutter/material.dart';
import 'package:pilipala/common/skeleton/skeleton.dart';

class DynamicCardSkeleton extends StatelessWidget {
  const DynamicCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
        child: Column(
          children: [
            Row(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}
