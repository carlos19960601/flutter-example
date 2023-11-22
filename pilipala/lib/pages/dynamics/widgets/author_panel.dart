import 'package:flutter/material.dart';
import 'package:pilipala/common/widgets/network_img_layer.dart';
import 'package:pilipala/utils/utils.dart';

class AuthorPanel extends StatelessWidget {
  final dynamic item;
  const AuthorPanel({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    String heroTag = Utils.makeHeroTag(item.modules.moduleAuthor.mid);
    return Row(
      children: [
        GestureDetector(
          child: Hero(
            tag: heroTag,
            child: NetworkImgLayer(
              width: 40,
              height: 40,
              type: "avatar",
              src: item.modules.moduleAuthor.face,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.modules.moduleAuthor.name,
              style: TextStyle(
                color: item.modules.moduleAuthor!.vip != null &&
                        item.modules.moduleAuthor!.vip['status'] > 0
                    ? const Color.fromARGB(255, 251, 100, 163)
                    : Theme.of(context).colorScheme.onBackground,
                fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
              ),
            ),
            DefaultTextStyle.merge(
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
              ),
              child: Row(
                children: [
                  Text(item.modules.moduleAuthor.pubTime),
                  if (item.modules.moduleAuthor.pubTime != '' &&
                      item.modules.moduleAuthor.pubAction != '')
                    const Text(' '),
                  Text(item.modules.moduleAuthor.pubAction),
                ],
              ),
            )
          ],
        ),
        const Spacer(),
        if (item.type == 'DYNAMIC_TYPE_AV')
          SizedBox(
            width: 32,
            height: 32,
            child: IconButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  isScrollControlled: true,
                  builder: (context) {
                    return MorePanel(item: item);
                  },
                );
              },
              icon: const Icon(Icons.more_vert_outlined, size: 18),
            ),
          ),
      ],
    );
  }
}

class MorePanel extends StatelessWidget {
  final dynamic item;
  const MorePanel({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
