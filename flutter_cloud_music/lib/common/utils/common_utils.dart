import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/functions.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();

void afterLogin(ParamVoidCallback callback) {
  if (AuthService.to.isLoggedInValue) {
    callback.call();
  } else {
    Get.toNamed(Routes.LOGIN);
  }
}

Widget buildUserAvatar(String? url, Size size) {
  return SizedBox.fromSize(
    size: size,
    child: CircleAvatar(
      radius: size.height / 2,
      child: CachedNetworkImage(
        imageUrl: url ?? "",
        placeholder: (context, url) {
          return _buildAvaterHolder(size);
        },
        errorWidget: (context, url, error) {
          return _buildAvaterHolder(size);
        },
        imageBuilder: (context, imageProvider) {
          return ClipOval(
            child: Image(image: imageProvider),
          );
        },
      ),
    ),
  );
}

Widget _buildAvaterHolder(Size size) {
  return Stack(
    children: [
      SizedBox(
        width: size.width,
        height: size.height,
        child: Image.asset(
          ImageUtils.getImagePath('ce2'),
          fit: BoxFit.cover,
          color: const Color(0xfff8bfbd),
        ),
      ),
    ],
  );
}

String getPlayCountStrFromInt(int count) {
  if (count < 100000) {
    return '$count';
  } else if (count >= 100000 && count <= 99999999) {
    return '${count ~/ 10000}万';
  } else {
    return '${(count / 100000000).toStringAsFixed(1)}亿';
  }
}

Widget errorWidget(BuildContext context, String url, dynamic e) => Container(
      color: AppColors.loadImagePlaceholder(),
    );
