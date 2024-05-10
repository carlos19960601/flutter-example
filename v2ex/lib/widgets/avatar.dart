import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:v2ex/utils/utils.dart';

class CAvatar extends StatelessWidget {
  const CAvatar({
    super.key,
    required this.url,
    required this.size,
    this.fadeOutDuration,
    this.fadeInDuration,
    this.quality,
  });

  final String url;
  final double size;
  final int radius = 50;
  final Duration? fadeOutDuration;
  final Duration? fadeInDuration;
  final String? quality;

  @override
  Widget build(BuildContext context) {
    return url.isNotEmpty
        ? ClipOval(
            child: CachedNetworkImage(
              imageUrl: quality == "origin" ? Utils().avatarLarge(url) : url,
              height: size,
              width: size,
              fit: BoxFit.cover,
            ),
          )
        : errAvatar(context);
  }

  Widget errAvatar(context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(50),
      ),
      width: size,
      height: size,
      child: Center(
        child: Icon(
          Icons.person_rounded,
          size: size - 10,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
