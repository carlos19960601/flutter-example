import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/http/user.dart';
import 'package:pilipala/http/video.dart';
import 'package:pilipala/models/video/video_detail_res.dart';
import 'package:pilipala/utils/id_utils.dart';
import 'package:pilipala/utils/storage.dart';

class VideoIntroController extends GetxController {
  // 视频bvid
  String bvid = Get.parameters['bvid']!;
  // 视频详情 请求返回
  Rx<VideoDetailData> videoDetail = VideoDetailData().obs;
  bool userLogin = false;
  Box userInfoCache = GStorage.userInfo;
  var userInfo;
  RxInt lastPlayCid = 0.obs;
  // up主粉丝数
  Map userStat = {'follower': '-'};
  // 是否点赞
  RxBool hasLike = false.obs;
  // 是否投币
  RxBool hasCoin = false.obs;
  // 是否收藏
  RxBool hasFav = false.obs;
  // 关注状态 默认未关注
  RxMap followStatus = {}.obs;
  // 视频详情 上个页面传入
  Map? videoItem = {};
  // 是否预渲染 骨架屏
  bool preRender = false;
  // 同时观看
  bool isShowOnlineTotal = false;
  RxString total = '1'.obs;

  @override
  void onInit() {
    super.onInit();
    userInfo = userInfoCache.get('userInfoCache');
    userLogin = userInfo != null;

    if (Get.arguments.isNotEmpty) {
      if (Get.arguments.containsKey('videoItem')) {
        preRender = true;
        var args = Get.arguments['videoItem'];
        videoItem!['pic'] = args.pic;
        if (args.title is String) {
          videoItem!['title'] = args.title;
        } else {
          String str = '';
          for (Map map in args.title) {
            str += map['text'];
          }
          videoItem!['title'] = str;
        }
        if (args.stat != null) {
          videoItem!['stat'] = args.stat;
        }
        videoItem!['pubdate'] = args.pubdate;
        videoItem!['owner'] = args.owner;
      }
    }
  }

  // 获取视频简介&分p
  Future queryVideoIntro() async {
    log("videoIntro: ${bvid}");
    var result = await VideoHttp.videoIntro(bvid: bvid);
    if (result['status']) {
      videoDetail.value = result['data']!;
      if (videoDetail.value.pages!.isNotEmpty && lastPlayCid.value == 0) {
        lastPlayCid.value = videoDetail.value.pages!.first.cid!;
      }
      await queryUserStat();
    }
    if (userLogin) {
      // 获取点赞状态
      queryHasLikeVideo();
      // 获取投币状态
      queryHasCoinVideo();
      // 获取收藏状态
      queryHasFavVideo();
      //
      queryFollowStatus();
    }
    return result;
  }

  // 获取up主粉丝数
  Future queryUserStat() async {
    var result = await UserHttp.userStat(mid: videoDetail.value.owner!.mid!);
    if (result['status']) {
      userStat = result['data'];
    }
  }

  // 获取点赞状态
  Future queryHasLikeVideo() async {
    var result = await VideoHttp.hasLikeVideo(bvid: bvid);
    // data	num	被点赞标志	0：未点赞  1：已点赞
    hasLike.value = result["data"] == 1 ? true : false;
  }

  // 获取投币状态
  Future queryHasCoinVideo() async {
    var result = await VideoHttp.hasCoinVideo(bvid: bvid);
    hasCoin.value = result["data"]['multiply'] == 0 ? false : true;
  }

  // 获取收藏状态
  Future queryHasFavVideo() async {
    /// fix 延迟查询
    await Future.delayed(const Duration(milliseconds: 200));
    var result = await VideoHttp.hasFavVideo(aid: IdUtils.bv2av(bvid));
    if (result['status']) {
      hasFav.value = result["data"]['favoured'];
    } else {
      hasFav.value = false;
    }
  }

  // 查询关注状态
  Future queryFollowStatus() async {
    if (videoDetail.value.owner == null) {
      return;
    }
    var result = await VideoHttp.hasFollow(mid: videoDetail.value.owner!.mid!);
    if (result['status']) {
      followStatus.value = result['data'];
    }
    return result;
  }
}
