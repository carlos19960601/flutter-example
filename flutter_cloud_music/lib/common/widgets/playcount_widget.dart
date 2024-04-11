import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';

class PlayCountWidget extends StatelessWidget {
  const PlayCountWidget({
    super.key,
    required this.playCount,
    this.needBg = true,
  });

  final int playCount;
  final bool needBg;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      color: needBg ? Colors.black.withOpacity(0.2) : Colors.transparent,
      child: _playcount(),
    );
  }

  Widget _playcount() {
    return Row(
      children: [
        Image.asset(
          ImageUtils.getImagePath('icon_playcount'),
          width: 8,
          height: 8,
        ),
        const SizedBox(width: 1),
        Text(
          getPlayCountStrFromInt(playCount),
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 10,
          ),
        )
      ],
    );
  }
}
