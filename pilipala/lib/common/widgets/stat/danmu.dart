import 'package:flutter/material.dart';
import 'package:pilipala/utils/utils.dart';

class StatDanMu extends StatelessWidget {
  final String? theme;
  final int? danmu;
  final String? size;

  const StatDanMu({super.key, this.theme, this.danmu, this.size});

  @override
  Widget build(BuildContext context) {
    Map<String, Color> colorObject = {
      'white': Colors.white,
      'gray': Theme.of(context).colorScheme.outline,
      'black': Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
    };
    Color color = colorObject[theme]!;

    return Row(
      children: [
        Icon(
          Icons.subtitles_outlined,
          size: 14,
          color: color,
        ),
        const SizedBox(width: 2),
        Text(
          Utils.numFormat(danmu!),
          style: TextStyle(
            fontSize: size == 'medium' ? 12 : 11,
            color: color,
          ),
        )
      ],
    );
  }
}
