import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:v2ex/pages/t/:topicId.dart';
import 'package:v2ex/utils/storage.dart';

class ResizeLayout extends StatefulWidget {
  Widget leftLayout;
  Widget? rightLayout;

  ResizeLayout({super.key, required this.leftLayout, this.rightLayout});

  @override
  State<ResizeLayout> createState() => _ResizeLayoutState();
}

class _ResizeLayoutState extends State<ResizeLayout> {
  final double _offset = GStorage().getDragOffset();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool isiPadHorizontal = Breakpoints.large.isActive(context);
        bool isiPadVertical = Breakpoints.medium.isActive(context);

        double maxWidth = constraints.maxWidth;
        double dividerWidth = isiPadVertical ? 8 : 16;
        double rightSafeOffest = 12;

        // 左右比例
        double lfScale = 0.75;
        double rgScale = 1 - lfScale;
        double minScale = 0.35;

        final lfWidth = (maxWidth - dividerWidth - rightSafeOffest) * lfScale;
        final rgWidth = (maxWidth - dividerWidth - rightSafeOffest) * rgScale;
        final minWidth = (maxWidth - dividerWidth - rightSafeOffest) * minScale;

        return Row(
          children: [
            SizedBox(
              width: isiPadHorizontal ? lfWidth + _offset : maxWidth,
              child: SafeArea(child: widget.leftLayout),
            ),
            if (isiPadHorizontal) ...[
              SizedBox(
                width: dividerWidth,
                child: isiPadHorizontal ? const DragDivider() : null,
              ),
              SizedBox(
                width: rgWidth - _offset,
                child: SafeArea(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: widget.rightLayout ?? const TopicDetail(),
                  ),
                ),
              ),
              SizedBox(width: rightSafeOffest),
            ],
          ],
        );
      },
    );
  }
}

class DragDivider extends StatelessWidget {
  const DragDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {},
      child: MouseRegion(
        cursor: SystemMouseCursors.alias,
        child: Center(
          child: Container(
            width: 4,
            height: 30,
            margin: const EdgeInsets.only(left: 3, right: 3),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
