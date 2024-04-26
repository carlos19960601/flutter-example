import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/http/video.dart';
import 'package:pilipala/models/home/rcmd/result.dart';

class RcmdController extends GetxController {
  int _currentPage = 0;
  bool isLoadingMore = true;
  RxList<RecVideoItemAppModel> videoList = <RecVideoItemAppModel>[].obs;
  final ScrollController scrollController = ScrollController();
  RxInt crossAxisCount = 2.obs;

  Future queryRcmdFeed(type) async {
    if (!isLoadingMore) {
      return;
    }

    if (type == "onRefresh") {
      _currentPage = 0;
    }
    var res = await VideoHttp.rcmdVideoListApp(
      freshIdx: _currentPage,
    );

    if (res["status"]) {
      if (type == "init") {
        if (videoList.isNotEmpty) {
          videoList.addAll(res["data"]);
        } else {
          videoList.value = res["data"];
        }
      } else if (type == "onRefresh") {
        videoList.value = res["data"];
      } else if (type == "onLoad") {
        videoList.addAll(res['data']);
      }
      _currentPage += 1;
    }
    isLoadingMore = false;
    return res;
  }

  // 下拉刷新
  Future onRefresh() async {
    isLoadingMore = true;
    queryRcmdFeed("onRefresh");
  }

  // 上拉加载
  Future onLoad() async {
    queryRcmdFeed("onLoad");
  }
}
