import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:pilipala/common/constants.dart';
import 'package:pilipala/common/widgets/badge.dart';
import 'package:pilipala/common/widgets/network_img_layer.dart';
import 'package:pilipala/common/widgets/stat/danmu.dart';
import 'package:pilipala/common/widgets/stat/view.dart';
import 'package:pilipala/http/search.dart';
import 'package:pilipala/http/user.dart';
import 'package:pilipala/utils/utils.dart';

class VideoCardH extends StatelessWidget {
  final videoItem;
  final Function()? longPress;
  final Function()? longPressEnd;
  final String source;

  const VideoCardH({
    super.key,
    required this.videoItem,
    this.longPress,
    this.longPressEnd,
    this.source = "normal",
  });

  @override
  Widget build(BuildContext context) {
    int aid = videoItem.aid!;
    String bvid = videoItem.bvid!;
    String heroTag = Utils.makeHeroTag(aid);
    return GestureDetector(
      onLongPress: () {
        if (longPress != null) {
          longPress!();
        }
      },
      child: InkWell(
        onTap: () async {
          try {
            int cid =
                videoItem.cid ?? await SearchHttp.ab2c(aid: aid, bvid: bvid);
            Get.toNamed('/video?bvid=$bvid&cid=$cid',
                arguments: {'videoItem': videoItem, 'heroTag': heroTag});
          } catch (err) {
            SmartDialog.showToast(err.toString());
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              StyleString.safeSpace, 5, StyleString.safeSpace, 5),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double width = (constraints.maxWidth -
                      StyleString.cardSpace *
                          6 /
                          MediaQuery.of(context).textScaleFactor) /
                  2;
              return Container(
                constraints: const BoxConstraints(minHeight: 88),
                height: width / StyleString.aspectRatio,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  width: maxWidth,
                                  height: maxHeight,
                                  src: videoItem.pic,
                                ),
                              ),
                              PBadge(
                                text: Utils.timeFormat(videoItem.duration!),
                                top: null,
                                right: 6.0,
                                bottom: 6.0,
                                left: null,
                                type: 'gray',
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    VideoContent(
                      videoItem: videoItem,
                      source: source,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class VideoContent extends StatelessWidget {
  final videoItem;
  final String source;

  const VideoContent({super.key, this.videoItem, this.source = "normal"});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 6, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (videoItem.title is String) ...[
              Text(
                videoItem.title.toString(),
                textAlign: TextAlign.start,
                style: const TextStyle(fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ] else ...[
              RichText(
                maxLines: 2,
                text: TextSpan(
                  children: [
                    for (var i in videoItem.title) ...[
                      TextSpan(
                        text: i["text"],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                          color: i['type'] == 'em'
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      )
                    ]
                  ],
                ),
              ),
            ],
            const Spacer(),
            Row(
              children: [
                Text(
                  videoItem.owner.name,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.labelMedium!.fontSize,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                StatView(
                  theme: 'gray',
                  view: videoItem.stat.view,
                ),
                const SizedBox(width: 8),
                StatDanMu(
                  theme: 'gray',
                  danmu: videoItem.stat.danmaku,
                ),
                const Spacer(),
                if (source == 'normal')
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      tooltip: '稍后再看',
                      icon: Icon(
                        Icons.more_vert_outlined,
                        color: Theme.of(context).colorScheme.outline,
                        size: 14,
                      ),
                      position: PopupMenuPosition.under,
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          onTap: () async {
                            var res = await UserHttp.toViewLater(
                                bvid: videoItem.bvid);
                            SmartDialog.showToast(res['msg']);
                          },
                          value: 'pause',
                          height: 35,
                          child: const Row(
                            children: [
                              Icon(Icons.watch_later_outlined, size: 16),
                              SizedBox(width: 6),
                              Text('稍后再看', style: TextStyle(fontSize: 13))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
