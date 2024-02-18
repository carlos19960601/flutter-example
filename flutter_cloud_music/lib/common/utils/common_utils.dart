import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/functions.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/models/song_model.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

Widget paddingBottomBox({double append = 0}) {
  final bottom = Get.mediaQuery.padding.bottom + append;
  return Obx(
    () => SizedBox(
        height: PlayerService.to.curPlay.value == null ? bottom : bottom + 58),
  );
}

Widget errorWidget(BuildContext context, String url, dynamic e) => Container(
      color: AppColors.loadImagePlaceholder(),
    );

List<Widget> getSongTags(Song song,
    {bool needOriginType = true,
    bool needNewType = true,
    bool needCopyright = true}) {
  final List<Widget> tags = List.empty(growable: true);
  final List<String> res = List.empty(growable: true);

  if (song.fee == 1) {
    res.add(ImageUtils.getImagePath('d2d'));
    if (song.privilege?.fee == 0) {
      res.add(ImageUtils.getImagePath('dx1'));
    }
  }
  if (song.copyright == 1 && needCopyright) {
    res.add(ImageUtils.getImagePath('dwg'));
  }
  if (song.originCoverType == 1 && needOriginType) {
    res.add(ImageUtils.getImagePath('dwr'));
  }
  if (song.v <= 3 && needNewType) {
    res.add(ImageUtils.getImagePath('dwp'));
  }
  if (song.privilege?.preSell == true) {
    res.add(ImageUtils.getImagePath('dwv'));
  }
  if (song.privilege?.payed == 1) {
    res.add(ImageUtils.getImagePath('dw7'));
  }
  if (song.privilege?.getMaxPlayBr() == 999000) {
    res.add(ImageUtils.getImagePath('dwz'));
  }
  if (song.privilege?.freeTrialPrivilege?.resConsumable == true ||
      song.privilege?.freeTrialPrivilege?.userConsumable == true) {
    res.add(ImageUtils.getImagePath('ck4'));
  }
  // Get.log('ressize ${res.length}');
  for (final element in res) {
    tags.add(Image.asset(
      element,
      width: 19,
      height: 10,
      fit: BoxFit.contain,
    ));
  }

  return tags;
}

Future toast(dynamic message) async {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG);
}

Future<void> toPlaying() async {
  if (PlayerService.to.isFmPlaying.value) {
    Get.toNamed(Routes.PRIVATE_FM);
  } else {
    Get.toNamed(Routes.PLAYING);
  }
}

Future<void> toUserDetail({dynamic accountId, dynamic artistId}) async {
  return Get.toNamed(
    Routes.SINGER_DETAIL,
    arguments: {'accountId': accountId, 'artistId': artistId},
    preventDuplicates: false,
  );
}

Widget get leading => IconButton(
      onPressed: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        Get.back();
      },
      icon: Image.asset(
        ImageUtils.getImagePath('dij'),
        color: Get.theme.appBarTheme.titleTextStyle?.color,
        width: 25,
        height: 25,
      ),
    );
