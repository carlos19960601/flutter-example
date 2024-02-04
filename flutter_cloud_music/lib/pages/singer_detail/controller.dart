import 'dart:developer';

import 'package:flutter_cloud_music/http/api.dart';
import 'package:flutter_cloud_music/http/music.dart';
import 'package:flutter_cloud_music/models/singer_detail_model.dart';
import 'package:flutter_cloud_music/pages/singer_detail/state.dart';
import 'package:get/get.dart';

class SingerDetailController extends GetxController {
  final state = SingerDetailState();

  @override
  void onInit() {
    super.onInit();
    state.detail.listen((detail) {});
    _getDetail();
  }

  void _getDetail() {
    if (GetUtils.isNullOrBlank(state.accountId.value) == true) {
      log("======= 歌手");
      //获取歌手详情
      MusicHttp.getSingerInfo(state.artistId!)
          .then((ApiResponse<SingerDetailModel?> response) {
        state.accountId.value = response.data?.user?.userId.toString();
        state.detail.value = response.data?.detail;
      });
    } else {}
  }
}
