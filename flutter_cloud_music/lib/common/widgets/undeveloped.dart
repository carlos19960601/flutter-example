import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';

class UnDeveloped extends StatelessWidget {
  const UnDeveloped({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [
          Image.asset(
            ImageUtils.getImagePath("codeimg"),
          ),
        ],
      ),
    );
  }
}
