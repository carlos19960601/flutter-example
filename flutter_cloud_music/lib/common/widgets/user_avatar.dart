import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.avatar,
    this.size = 35,
    this.identityIconUrl,
    this.holderAsset,
  });

  final String avatar;
  final double size;
  final String? identityIconUrl;
  final String? holderAsset;

  @override
  Widget build(BuildContext context) {
    final sizeL = Size(size, size);
    return CachedNetworkImage(
      imageUrl: ImageUtils.getImageUrlFromSize(avatar, sizeL),
      width: size * 1.1,
      height: size,
    );
  }
}
