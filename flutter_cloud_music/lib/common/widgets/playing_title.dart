import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/widgets/marquee_on_demand.dart';
import 'package:flutter_cloud_music/models/song_model.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

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
            MarqueeOnDemand(
              switchWidth: Get.mediaQuery.size.width * 2 / 3,
              text: song?.name ?? "",
              marqueeBuilder: (context, text, textStyle) => Marquee(
                text: text,
                style: textStyle,
                velocity: 25,
                blankSpace: 30,
              ),
              textBuilder: (context, text, textStyle) => Text(
                text,
                style: textStyle,
              ),
              textStyle: const TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: Text(
                      song?.arString() ?? "",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7), fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 17,
                    color: Colors.white.withOpacity(0.7),
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
