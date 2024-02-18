import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/utils/theme_utils.dart';
import 'package:flutter_cloud_music/common/utils/time.dart';
import 'package:flutter_cloud_music/common/widgets/custom_tap.dart';
import 'package:flutter_cloud_music/models/singer_videos_model.dart';
import 'package:flutter_cloud_music/pages/found/models/shuffle_log_model.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widgets/video/controller.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widgets/video/state.dart';
import 'package:flutter_cloud_music/pages/video/view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';

class SingerVideoView extends StatelessWidget {
  SingerVideoView({super.key, required this.id});
  final int id;

  late SingerVideoController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(SingerVideoController(id));
    return Obx(() {
      if (controller.model.value != null) {
        return SmartRefresher(
          controller: controller.refreshController,
          onLoading: () async {
            controller.loadMore();
          },
          onRefresh: () async {
            controller.refreshData();
          },
          enablePullUp: true,
          enablePullDown: false,
          child: _buildContent(controller.model.value?.records),
        );
      }

      return const Placeholder();
    });
  }

  Widget _buildContent(List<Records>? records) {
    return ListView.separated(
        itemBuilder: (context, index) {
          final item = records!.elementAt(index);
          return Bounce(
              onPressed: () {
                final list = records
                    .map((e) => VideoModel(
                          id: e.resource.mlogBaseData.id,
                          resource: e.resource,
                        ))
                    .toList();
                VideoPage.startWithList(list, index: index);
              },
              child: _buildItem(item));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
        itemCount: records?.length ?? 0);
  }

  Widget _buildItem(Records item) {
    return Container(
      height: 84,
      width: Get.mediaQuery.size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ClipRRect(
            child: CachedNetworkImage(
              imageUrl: ImageUtils.getImageUrlFromSize(
                item.resource.mlogBaseData.coverUrl,
                const Size(150, 84),
              ),
              width: 150,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                item.resource.mlogBaseData.buildNameView(),
                const SizedBox(height: 4),
                Text(
                  millFormat(item.resource.mlogBaseData.pubTime),
                  style: captionStyle(),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  '${getPlayCountStrFromInt(item.resource.mlogExtVO.playCount ?? 0)}播放',
                  style: captionStyle(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
