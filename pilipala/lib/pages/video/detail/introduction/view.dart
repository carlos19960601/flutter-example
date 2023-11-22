import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/common/constants.dart';
import 'package:pilipala/common/widgets/http_error.dart';
import 'package:pilipala/common/widgets/stat/danmu.dart';
import 'package:pilipala/common/widgets/stat/view.dart';
import 'package:pilipala/models/video/video_detail_res.dart';
import 'package:pilipala/pages/video/detail/controller.dart';
import 'package:pilipala/pages/video/detail/introduction/controller.dart';
import 'package:pilipala/utils/utils.dart';

class VideoIntroPanel extends StatefulWidget {
  const VideoIntroPanel({super.key});

  @override
  State<VideoIntroPanel> createState() => _VideoIntroPanelState();
}

class _VideoIntroPanelState extends State<VideoIntroPanel> {
  late String heroTag;
  late VideoIntroController videoIntroController;
  VideoDetailData? videoDetail;
  late Future? _futureBuilderFuture;

  @override
  void initState() {
    super.initState();
    heroTag = Get.arguments['heroTag'];
    videoIntroController = Get.put(VideoIntroController(), tag: heroTag);
    _futureBuilderFuture = videoIntroController.queryVideoIntro();
    videoIntroController.videoDetail.listen((value) {
      videoDetail = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureBuilderFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return const SliverToBoxAdapter(child: SizedBox());
          }
          if (snapshot.data['status']) {
            // 请求成功
            return Obx(
              () => VideoInfo(
                loadingStatus: false,
                videoDetail: videoIntroController.videoDetail.value,
                heroTag: heroTag,
              ),
            );
          } else {
            // 请求错误
            return HttpError(
              errMsg: snapshot.data['msg'],
              btnText: snapshot.data['code'] == -404 ||
                      snapshot.data['code'] == 62002
                  ? '返回上一页'
                  : null,
              fn: () => Get.back(),
            );
          }
        } else {
          return VideoInfo(
            loadingStatus: true,
            videoDetail: videoDetail,
            heroTag: heroTag,
          );
        }
      },
    );
  }
}

class VideoInfo extends StatefulWidget {
  final bool loadingStatus;
  final VideoDetailData? videoDetail;
  final String? heroTag;
  const VideoInfo(
      {super.key, this.loadingStatus = false, this.videoDetail, this.heroTag});

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  late String heroTag;
  late final Map<dynamic, dynamic> videoItem;
  late final bool loadingStatus; // 加载状态
  late final VideoIntroController videoIntroController;
  late final VideoDetailController videoDetailCtr;

  @override
  void initState() {
    super.initState();
    heroTag = widget.heroTag!;
    videoIntroController = Get.put(VideoIntroController(), tag: heroTag);
    videoDetailCtr = Get.find<VideoDetailController>(tag: heroTag);
    videoItem = videoIntroController.videoItem!;
    loadingStatus = widget.loadingStatus;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData t = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.only(
          left: StyleString.safeSpace, right: StyleString.safeSpace, top: 10),
      sliver: SliverToBoxAdapter(
          child: !loadingStatus || videoItem.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Text(
                        !loadingStatus
                            ? widget.videoDetail!.title
                            : videoItem['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Stack(
                      children: [
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 7, bottom: 6),
                            child: Row(
                              children: [
                                StatView(
                                  theme: 'gray',
                                  view: !widget.loadingStatus
                                      ? widget.videoDetail!.stat!.view
                                      : videoItem['stat'].view,
                                  size: 'medium',
                                ),
                                const SizedBox(width: 10),
                                StatDanMu(
                                  theme: 'gray',
                                  danmu: !widget.loadingStatus
                                      ? widget.videoDetail!.stat!.danmaku
                                      : videoItem['stat'].danmaku,
                                  size: 'medium',
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  Utils.dateFormat(
                                      !widget.loadingStatus
                                          ? widget.videoDetail!.pubdate
                                          : videoItem['pubdate'],
                                      formatType: 'detail'),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: t.colorScheme.outline,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                if (videoIntroController.isShowOnlineTotal)
                                  Obx(
                                    () => Text(
                                      '${videoIntroController.total.value}人在看',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: t.colorScheme.outline,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 6,
                          child: GestureDetector(
                            child:
                                Image.asset('assets/images/ai.png', height: 22),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : const SizedBox(
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
    );
  }
}
