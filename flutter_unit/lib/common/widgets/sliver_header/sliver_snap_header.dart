import 'package:flutter/material.dart';

class SliverSnapHeader extends StatefulWidget {
  const SliverSnapHeader({
    super.key,
    required this.child,
  });

  final PreferredSizeWidget child;

  @override
  State<SliverSnapHeader> createState() => _SliverSnapHeaderState();
}

class _SliverSnapHeaderState extends State<SliverSnapHeader> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverSnapHeaderDelegate(
        child: widget.child,
      ),
    );
  }
}

class _SliverSnapHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SliverSnapHeaderDelegate({
    required this.child,
  });

  final PreferredSizeWidget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SliverSnapHeaderDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
