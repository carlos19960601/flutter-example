import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pilipala/plugin/pl_player/controller.dart';
import 'package:pilipala/plugin/pl_player/utils.dart';
import 'package:pilipala/plugin/pl_player/widgets/common_btn.dart';

class BottomControl extends StatelessWidget implements PreferredSizeWidget {
  final PlPlayerController? controller;
  final Function? triggerFullScreen;

  const BottomControl({super.key, this.controller, this.triggerFullScreen});

  @override
  Widget build(BuildContext context) {
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
        children: [
          Row(
            children: [
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
                  fuc: () => triggerFullScreen!(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
