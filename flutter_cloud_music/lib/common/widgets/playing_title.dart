import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/widgets/marquee_on_demand.dart';
import 'package:flutter_cloud_music/models/song_model.dart';
import 'package:get/get.dart';

class PlayingTitle extends StatelessWidget {
  const PlayingTitle({
    super.key,
    required this.song,
  });

  final Song? song;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: AppBar(
        elevation: 0,
        primary: false,
        leadingWidth: 46,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: const EdgeInsets.only(left: 22),
            child: Image.asset(
              ImageUtils.getImagePath("list_icn_arr_open"),
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const MarqueeOnDemand(),
            InkWell(
              child: Row(
                children: [
                  Container(
                    child: Text(song?.arString() ?? ""),
                  ),
                ],
              ),
            )
          ],
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: Image.asset(
                ImageUtils.getImagePath("icn_share"),
                width: 28,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
