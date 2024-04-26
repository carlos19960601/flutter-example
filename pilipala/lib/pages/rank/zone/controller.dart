import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/http/video.dart';
import 'package:pilipala/models/model_hot_video_item.dart';

class ZoneController extends GetxController {
  int zoneID = 0;

  final ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  RxList<HotVideoItemModel> videoList = <HotVideoItemModel>[].obs;

  // 获取推荐
  Future queryRankFeed(type, rid) async {
    zoneID = rid;
    var res = await VideoHttp.getRankVideoList(zoneID);
    if (res["status"]) {
      if (type == 'init') {
        videoList.value = res['data'];
      } else if (type == 'onRefresh') {
        videoList.clear();
        videoList.addAll(res['data']);
      } else if (type == 'onLoad') {
        videoList.clear();
        videoList.addAll(res['data']);
      }
    }

    isLoadingMore = false;
    return res;
  }

  // 下拉刷新
  Future onRefresh() async {
    queryRankFeed('onRefresh', zoneID);
  }

  // 上拉加载
  Future onLoad() async {
    queryRankFeed('onLoad', zoneID);
  }

  void animateToTop() async {
    if (scrollController.offset >= Get.mediaQuery.size.height * 5) {
      scrollController.jumpTo(0);
    } else {
      await scrollController.animateTo(0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }
}
