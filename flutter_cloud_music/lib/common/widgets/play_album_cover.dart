import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/widgets/rotation_cover_image.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/models/song_model.dart';
import 'package:flutter_cloud_music/pages/playing/controller.dart';
import 'package:get/get.dart';

class PlayAlbumCover extends StatefulWidget {
  const PlayAlbumCover({
    super.key,
    this.music,
  });

  final Song? music;

  @override
  State<PlayAlbumCover> createState() => _PlayAlbumCoverState();
}

class _PlayAlbumCoverState extends State<PlayAlbumCover>
    with SingleTickerProviderStateMixin {
  static double kHeightSpaceAlbumTop = 72;

  final playController = Get.find<PlayingController>();

  late AnimationController _needleController;
  late Animation<double> _needleAnimation;

  AnimationController? _translateController;

  bool _needleAttachCover = false;

  double _coverTranslateX = 0;

  ///当前播放中的音乐
  Song? _current;

  @override
  void initState() {
    super.initState();
    _needleController = AnimationController(
      vsync: this,
      value: _needleAttachCover ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
    );
    _needleAnimation = Tween<double>(begin: -1 / 12, end: 0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_needleController);
    _current = widget.music;
    _checkNeedleAndCoverStatus();
  }

  _checkNeedleAndCoverStatus() {
    const bool attachToCover = true;
    _rotateNeedle(attachToCover);
  }

  ///是否需要抓转Needle到封面上
  void _rotateNeedle(bool attachToCover) {
    if (_needleAttachCover == attachToCover) {
      return;
    }
    _needleAttachCover = attachToCover;
    if (attachToCover) {
      _needleController.forward(from: _needleController.value);
    }
  }

  @override
  void didUpdateWidget(covariant PlayAlbumCover oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _coverTranslateX = 0;
      _current = widget.music;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.only(top: kHeightSpaceAlbumTop),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 310, maxWidth: 310),
              child: Stack(
                children: [
                  Image.asset(
                    ImageUtils.getImagePath('play_disc_mask'),
                    fit: BoxFit.cover,
                  ),
                  RotationCoverImage(
                    rotating: true,
                    music: _current,
                    padding: 60,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
