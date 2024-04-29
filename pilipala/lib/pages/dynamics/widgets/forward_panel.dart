import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/pages/dynamics/widgets/video_panel.dart';
import 'package:pilipala/utils/utils.dart';

Widget forWard(item, context, ctr, source, {floor = 1}) {
  TextStyle authorStyle =
      TextStyle(color: Theme.of(context).colorScheme.primary);
  switch (item.type) {
    // 图文
    case 'DYNAMIC_TYPE_DRAW':
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (floor == 2) ...[
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.toNamed(
                    '/member?mid=${item.modules.moduleAuthor.mid}',
                    arguments: {'face': item.modules.moduleAuthor.face}),
                child: Text(
                  '@${item.modules.moduleAuthor.name}',
                  style: authorStyle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                Utils.dateFormat(item.modules.moduleAuthor.pubTs),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: Theme.of(context).textTheme.labelSmall!.fontSize),
              ),
            ],
          ),
          const SizedBox(height: 2),
        ],
      ]);
    case 'DYNAMIC_TYPE_AV':
      return videoSeasonWidget(item, context, 'archive', floor: floor);
    default:
      return const SizedBox(
        width: double.infinity,
        child: Text('🙏 暂未支持的类型，请联系开发者反馈 '),
      );
  }
}
