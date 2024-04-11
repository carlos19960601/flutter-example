import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/utils/theme_utils.dart';
import 'package:flutter_cloud_music/common/widgets/follow/follow_widget.dart';
import 'package:flutter_cloud_music/models/artists_model.dart';
import 'package:flutter_cloud_music/pages/singer_list/controller.dart';
import 'package:flutter_cloud_music/pages/singer_list/widgets/filter_header.dart';
import 'package:get/get.dart';
import 'package:sticky_headers/sticky_headers.dart';

class SingerListPage extends StatelessWidget {
  SingerListPage({super.key});
  final controller = Get.put(SingerListController());
  final state = Get.find<SingerListController>().singerListState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FilterHeader(),
        Expanded(
          child: Obx(
            () => ListView.builder(
              controller: state.scrollController,
              itemCount: controller.indexArtistsList.length,
              itemBuilder: (BuildContext context, int index) {
                return StickyHeader(
                  header: Container(
                    height: 25,
                    color: Get.isDarkMode
                        ? const Color(0xff292929)
                        : AppColors.color245,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.indexArtistsList
                          .elementAt(index)
                          .getIndexName(),
                      style: headlineStyle().copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  content: Column(
                    children: _buildGroup(
                        controller.indexArtistsList.elementAt(index).artists),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildGroup(List<Artists> artists) {
    return artists
        .map(
          (ar) => Material(
            color: Get.theme.cardColor,
            child: InkWell(
              onTap: () {
                toUserDetail(accountId: ar.accountId, artistId: ar.id);
              },
              child: SizedBox(
                height: 70,
                width: double.infinity,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: ImageUtils.getImageUrlFromSize(
                          ar.img1v1Url,
                          const Size(70, 70),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: ar.name,
                              style: headline2Style().copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (ar.getExtraStr() == null)
                              const WidgetSpan(child: SizedBox(width: 4)),
                            if (ar.getExtraStr() != null)
                              TextSpan(
                                text: ar.getExtraStr(),
                                style: headline2Style().copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.color150),
                              ),
                            if (ar.accountId != null)
                              WidgetSpan(
                                  child: ClipOval(
                                child: Container(
                                  child: Image.asset(
                                    ImageUtils.getImagePath('icn_account'),
                                    height: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 26,
                      width: 64,
                      margin: const EdgeInsets.only(left: 8, right: 16),
                      child: FollowWidget(
                        id: ar.id.toString(),
                        isFollowed: ar.followed,
                        isSolidWidget: false,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}
