import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pilipala/plugin/pl_player/controller.dart';
import 'package:pilipala/plugin/pl_player/utils.dart';
import 'package:pilipala/plugin/pl_player/widgets/common_btn.dart';
import 'package:pilipala/plugin/pl_player/widgets/play_pause.btn.dart';

class BottomControl extends StatelessWidget implements PreferredSizeWidget {
  final PlPlayerController? controller;
  final Function? triggerFullScreen;

  const BottomControl({super.key, this.controller, this.triggerFullScreen});

  @override
  Widget build(BuildContext context) {
    Color colorTheme = Theme.of(context).colorScheme.primary;
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 12,
    );
    final _ = controller!;

    return Container(
      color: Colors.transparent,
      height: 85,
      padding: const EdgeInsets.only(left: 14, right: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(() {
            final int max = _.duration.value.inSeconds;
            final int value = _.sliderPosition.value.inSeconds;
            final int buffer = _.buffered.value.inSeconds;
            return Padding(
              padding: const EdgeInsets.only(left: 7, right: 7, bottom: 6),
              child: ProgressBar(
                progress: Duration(seconds: value),
                total: Duration(seconds: max),
                buffered: Duration(seconds: buffer),
                barHeight: 3.0,
                thumbRadius: 5,
                progressBarColor: colorTheme,
                baseBarColor: Colors.white.withOpacity(0.2),
                bufferedBarColor: colorTheme.withOpacity(0.4),
                timeLabelLocation: TimeLabelLocation.none,
                thumbColor: colorTheme,
                onDragStart: (ThumbDragDetails details) {
                  _.onChangedSliderStart();
                },
                onDragUpdate: (ThumbDragDetails details) {
                  _.onUpdatedSliderProgress(details.timeStamp);
                },
                onSeek: (Duration duration) {
                  _.onChangedSliderEnd();
                  _.onChangedSlider(duration.inSeconds.toDouble());
                  _.seekTo(Duration(seconds: duration.inSeconds));
                },
              ),
            );
          }),
          Row(
            children: [
              PlayOrPauseButton(
                controller: _,
              ),
              const SizedBox(width: 4),
              // 播放时间
              Obx(() {
                return Text(
                  _.duration.value.inMinutes >= 60
                      ? printDurationWithHours(_.position.value)
                      : printDuration(_.position.value),
                  style: textStyle,
                );
              }),
              const SizedBox(width: 2),
              const Text('/', style: textStyle),
              const SizedBox(width: 2),
              Obx(
                () => Text(
                  _.duration.value.inMinutes >= 60
                      ? printDurationWithHours(_.duration.value)
                      : printDuration(_.duration.value),
                  style: textStyle,
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 30,
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
                  child: Obx(
                    () => Text(
                      _.videoFitDEsc.value,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // 全屏
              Obx(
                () => ComBtn(
                  icon: Icon(
                    _.isFullScreen.value
                        ? FontAwesomeIcons.compress
                        : FontAwesomeIcons.expand,
                    size: 15,
                    color: Colors.white,
                  ),
                  fuc: () => triggerFullScreen?.call(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
