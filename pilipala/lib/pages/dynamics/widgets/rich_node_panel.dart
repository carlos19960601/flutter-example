import 'package:flutter/material.dart';

InlineSpan richNode(item, context) {
  final spacer = _VerticalSpaceSpan(0.0);
  try {
    TextStyle authorStyle =
        TextStyle(color: Theme.of(context).colorScheme.primary);
    List<InlineSpan> spanChilds = [];

    dynamic richTextNodes;
    if (item.modules.moduleDynamic.desc != null) {
      richTextNodes = item.modules.moduleDynamic.desc.richTextNodes;
    } else if (item.modules.moduleDynamic.major != null) {
      // 动态页面 richTextNodes 层级可能与主页动态层级不同
      richTextNodes =
          item.modules.moduleDynamic.major.opus.summary.richTextNodes;
      if (item.modules.moduleDynamic.major.opus.title != null) {
        spanChilds.add(
          TextSpan(
            text: item.modules.moduleDynamic.major.opus.title + '\n',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        );
      }
    }

    if (richTextNodes == null || richTextNodes.isEmpty) {
      return spacer;
    }

    return spacer;
  } catch (err) {
    return spacer;
  }
}

class _VerticalSpaceSpan extends WidgetSpan {
  _VerticalSpaceSpan(double height)
      : super(child: SizedBox(height: height, width: double.infinity));
}
