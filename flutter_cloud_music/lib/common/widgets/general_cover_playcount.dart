import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/functions.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/widgets/playcount_widget.dart';
import 'package:get/get.dart';

class GeneralCoverPlayCount extends StatelessWidget {
  const GeneralCoverPlayCount({
    super.key,
    required this.imageUrl,
    required this.playCount,
    required this.coverSize,
    this.isVideoPl = false,
    this.coverRadius = 6.0,
    this.rightTopTagIcon,
    this.imageCallback,
  });

  final String imageUrl;
  final int playCount;
  final Size coverSize;
  final double coverRadius;
  final String? rightTopTagIcon;
  final bool isVideoPl;
  final ParamSingleCallback<ImageProvider>? imageCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 4,
          width: coverSize.width - 14,
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.shade300.withOpacity(0.2),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
        ),
        ClipRRect(
          child: CachedNetworkImage(
            imageUrl: ImageUtils.getImageUrlFromSize(imageUrl, coverSize),
            width: coverSize.width,
            height: coverSize.height,
            placeholder: (context, url) {
              return Container(
                color: AppColors.loadImagePlaceholder(),
              );
            },
            errorWidget: (context, url, error) {
              return Container(
                color: AppColors.loadImagePlaceholder(),
              );
            },
            imageBuilder: _buildConver,
          ),
        ),
      ],
    );
  }

  Widget _buildConver(BuildContext context, ImageProvider provider) {
    imageCallback?.call(provider);
    return Stack(
      children: [
        Image(
          image: provider,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            child: PlayCountWidget(playCount: playCount),
          ),
        ),
      ],
    );
  }
}
