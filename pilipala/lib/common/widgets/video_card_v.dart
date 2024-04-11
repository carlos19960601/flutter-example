import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:pilipala/common/constants.dart';
import 'package:pilipala/common/widgets/badge.dart';
import 'package:pilipala/common/widgets/network_img_layer.dart';
import 'package:pilipala/utils/id_utils.dart';
import 'package:pilipala/utils/utils.dart';

class VideoCardV extends StatelessWidget {
  final dynamic videoItem;
  final int crossAxisCount;
  final Function()? longPress;
  final Function()? longPressEnd;

  const VideoCardV({
    super.key,
    required this.videoItem,
    required this.crossAxisCount,
    this.longPress,
    this.longPressEnd,
  });

  onPushDetail(heroTag) async {
    String goto = videoItem.goto;
    switch (goto) {
      case "av":
        String bvid = videoItem.bvid ?? IdUtils.av2bv(videoItem.aid);
        Get.toNamed('/video?bvid=$bvid&cid=${videoItem.cid}', arguments: {
          // 'videoItem': videoItem,
          'pic': videoItem.pic,
          'heroTag': heroTag,
        });
        break;
      default:
        SmartDialog.showToast(videoItem.goto);
        Get.toNamed(
          '/webview',
          parameters: {
            'url': videoItem.uri,
            'type': 'url',
            'pageTitle': videoItem.title,
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    String heroTag = Utils.makeHeroTag(videoItem.id);
    return Card(
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.zero,
      child: GestureDetector(
        onLongPress: () {
          if (longPress != null) {
            longPress!();
          }
        },
        child: InkWell(
          onTap: () async => onPushDetail(heroTag),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: StyleString.aspectRatio,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double maxWidth = constraints.maxWidth;
                    double maxHeight = constraints.maxHeight;
                    return Stack(
                      children: [
                        Hero(
                          tag: heroTag,
                          child: NetworkImgLayer(
                            src: videoItem.pic,
                            width: maxWidth,
                            height: maxHeight,
                          ),
                        ),
                        if (videoItem.duration != null)
                          if (crossAxisCount == 1) ...[
                            PBadge(
                              bottom: 10,
                              right: 10,
                              text: videoItem.duration,
                            )
                          ] else ...[
                            PBadge(
                              bottom: 6,
                              right: 7,
                              size: 'small',
                              type: 'gray',
                              text: videoItem.duration,
                            ),
                          ]
                      ],
                    );
                  },
                ),
              ),
              VideoContent(
                  videoItem: videoItem, crossAxisCount: crossAxisCount),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoContent extends StatelessWidget {
  final dynamic videoItem;
  final int crossAxisCount;

  const VideoContent({super.key, this.videoItem, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: crossAxisCount == 1 ? 0 : 1,
        child: Padding(
          padding: crossAxisCount == 1
              ? const EdgeInsets.fromLTRB(9, 9, 9, 4)
              : const EdgeInsets.fromLTRB(5, 8, 5, 4),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      videoItem.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (videoItem.goto == "av" && crossAxisCount == 1) ...[
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ],
              ),
              if (crossAxisCount > 1) ...[
                const SizedBox(
                  height: 2,
                ),
                VideoStat(videoItem: videoItem),
              ],
              if (crossAxisCount == 1) const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    flex: crossAxisCount == 1 ? 0 : 1,
                    child: Text(
                      videoItem.owner.name,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.labelMedium!.fontSize,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                  if (videoItem.goto == "av" && crossAxisCount != 1) ...[
                    WatchLater(
                      size: 24,
                      iconSize: 24,
                      callFn: () {},
                    )
                  ] else ...[
                    const SizedBox(
                      height: 24,
                    )
                  ]
                ],
              ),
            ],
          ),
        ));
  }
}

class VideoStat extends StatelessWidget {
  final dynamic videoItem;

  const VideoStat({super.key, this.videoItem});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${videoItem.stat.view}观看',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        Text(
          ' • ${videoItem.stat.danmu}弹幕',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
            color: Theme.of(context).colorScheme.outline,
          ),
        )
      ],
    );
  }
}

class WatchLater extends StatelessWidget {
  final double? size;
  final double? iconSize;
  final Function? callFn;

  const WatchLater(
      {super.key, required this.size, required this.iconSize, this.callFn});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        tooltip: "稍后再看",
        icon: Icon(
          Icons.more_vert_outlined,
          color: Theme.of(context).colorScheme.outline,
          size: iconSize,
        ),
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
          PopupMenuItem(
            onTap: () => callFn!(),
            value: "pause",
            height: 35,
            child: const Row(
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  size: 16,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  "稍后再看",
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
