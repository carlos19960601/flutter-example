import 'dart:io';

import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pilipala/models/video/play/quality.dart';
import 'package:pilipala/pages/video/detail/controller.dart';
import 'package:pilipala/plugin/pl_player/controller.dart';
import 'package:pilipala/plugin/pl_player/models/play_repeat.dart';
import 'package:pilipala/plugin/pl_player/widgets/common_btn.dart';

class HeaderControl extends StatefulWidget implements PreferredSizeWidget {
  final PlPlayerController? controller;
  final VideoDetailController? videoDetailCtr;
  final Floating? floating;

  const HeaderControl({
    super.key,
    this.controller,
    this.videoDetailCtr,
    this.floating,
  });

  @override
  State<StatefulWidget> createState() => _HeaderControlState();

  @override
  Size get preferredSize => throw UnimplementedError();
}

class _HeaderControlState extends State<HeaderControl> {
  double buttonSpace = 8;
  TextStyle subTitleStyle = const TextStyle(fontSize: 12);
  TextStyle titleStyle = const TextStyle(fontSize: 14);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _ = widget.controller!;
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 12,
    );

    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      primary: false,
      centerTitle: false,
      titleSpacing: 14,
      title: Row(
        children: [
          ComBtn(
            icon: const Icon(
              FontAwesomeIcons.arrowLeft,
              size: 15,
              color: Colors.white,
            ),
            fuc: () => Get.back(),
          ),
          SizedBox(width: buttonSpace),
          ComBtn(
            icon: const Icon(
              FontAwesomeIcons.house,
              size: 15,
              color: Colors.white,
            ),
            fuc: () async {
              // 销毁播放器实例
              await widget.controller!.dispose(type: 'all');
              if (mounted) {
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            },
          ),
          const Spacer(),
          SizedBox(
            width: 34,
            height: 34,
            child: Obx(
              () => IconButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: () {
                  _.isOpenDanmu.value = !_.isOpenDanmu.value;
                },
                icon: Icon(
                  _.isOpenDanmu.value
                      ? Icons.subtitles_outlined
                      : Icons.subtitles_off_outlined,
                  size: 19,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: buttonSpace),
          if (Platform.isAndroid) ...[
            SizedBox(
              width: 34,
              height: 34,
              child: IconButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: () async {},
                icon: const Icon(
                  Icons.picture_in_picture_outlined,
                  size: 19,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: buttonSpace),
          ],
          Obx(
            () => SizedBox(
              width: 45,
              height: 34,
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: () => showSetSpeedSheet(),
                child: Text(
                  '${_.playbackSpeed.toString()}X',
                  style: textStyle,
                ),
              ),
            ),
          ),
          SizedBox(width: buttonSpace),
          ComBtn(
            icon: const Icon(
              FontAwesomeIcons.sliders,
              size: 15,
              color: Colors.white,
            ),
            fuc: () => showSettingSheet(),
          ),
        ],
      ),
    );
  }

  /// 选择倍速
  void showSetSpeedSheet() {
    double currentSpeed = widget.controller!.playbackSpeed;
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('播放速度'),
          content: StatefulBuilder(builder: (context, StateSetter setState) {
            return Wrap();
          }),
          actions: [
            TextButton(
              onPressed: () => SmartDialog.dismiss(),
              child: Text(
                '取消',
                style: TextStyle(color: Theme.of(context).colorScheme.outline),
              ),
            ),
            TextButton(
              onPressed: () async {
                await widget.controller!.setDefaultSpeed();
                Get.back();
              },
              child: const Text('默认速度'),
            ),
          ],
        );
      },
    );
  }

  /// 设置面板
  void showSettingSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      builder: (_) {
        return Container(
          width: double.infinity,
          height: 440,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 35,
                child: Center(
                  child: Container(
                    width: 32,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondaryContainer
                          .withOpacity(0.5),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  child: ListView(
                    children: [
                      ListTile(
                        leading:
                            const Icon(Icons.network_cell_outlined, size: 20),
                        title: Text('省流模式', style: titleStyle),
                        subtitle: Text('低画质 ｜ 减少视频缓存', style: subTitleStyle),
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.play_circle_outline, size: 20),
                        title: Text('选择画质', style: titleStyle),
                        subtitle: Text(
                            '当前画质 ${widget.videoDetailCtr!.currentVideoQa.description}',
                            style: subTitleStyle),
                      ),
                      ListTile(
                        leading: const Icon(Icons.av_timer_outlined, size: 20),
                        title: Text('解码格式', style: titleStyle),
                        subtitle: Text(
                            '当前解码格式 ${widget.videoDetailCtr!.currentDecodeFormats.description}',
                            style: subTitleStyle),
                      ),
                      ListTile(
                        leading: const Icon(Icons.repeat, size: 20),
                        title: Text('播放顺序', style: titleStyle),
                        subtitle: Text(
                          widget.controller!.playRepeat.description,
                          style: subTitleStyle,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.subtitles_outlined, size: 20),
                        title: Text('弹幕设置', style: titleStyle),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
