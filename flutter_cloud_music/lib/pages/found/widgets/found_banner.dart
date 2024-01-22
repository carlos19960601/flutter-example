import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/models/banner_model.dart';
import 'package:flutter_cloud_music/pages/found/controller.dart';
import 'package:get/get.dart';

class FoundBanner extends StatefulWidget {
  const FoundBanner({
    super.key,
    required this.bannerModel,
    required this.itemHeight,
  });

  final BannerModel bannerModel;
  final double itemHeight;

  @override
  State<FoundBanner> createState() => _FoundBannerState();
}

class _FoundBannerState extends State<FoundBanner> {
  final FoundController foundController = Get.find<FoundController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.itemHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: Obx(
              () => Container(
                color: foundController.isScrolled.value
                    ? Get.theme.cardColor
                    : Colors.transparent,
              ),
            ),
          ),
          Swiper(
            index: 0,
            autoplayDelay: 6000,
            itemCount: widget.bannerModel.banner.length,
            itemBuilder: (context, index) {
              return _buildItem(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem(int index) {
    final banner = widget.bannerModel.banner[index];
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 5, 15, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: ImageUtils.getImageUrlFromSize(
              banner.pic,
              Size(Get.width - 30, 135),
            ),
            placeholder: (context, url) {
              return Container(color: AppColors.appMain);
            },
            imageBuilder: (context, imageProvider) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (!banner.showAdTag)
                    const SizedBox.shrink()
                  else
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 17,
                        decoration: BoxDecoration(
                          color: banner.titleColor == "red"
                              ? AppColors.appMain
                              : Get.theme.highlightColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Center(
                          child: Text(
                            banner.typeTitle!,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
