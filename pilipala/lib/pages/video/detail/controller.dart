import 'dart:developer';
import 'dart:io';

import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/http/constants.dart';
import 'package:pilipala/http/video.dart';
import 'package:pilipala/models/common/search_type.dart';
import 'package:pilipala/models/video/play/quality.dart';
import 'package:pilipala/models/video/play/url.dart';
import 'package:pilipala/pages/video/detail/widgets/header_control.dart';
import 'package:pilipala/plugin/pl_player/controller.dart';
import 'package:pilipala/plugin/pl_player/models/data_source.dart';
import 'package:pilipala/utils/storage.dart';
import 'package:pilipala/utils/utils.dart';

class VideoDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  String bvid = Get.parameters["bvid"]!;
  RxInt cid = int.parse(Get.parameters["cid"]!).obs;
  RxInt danmakuCid = 0.obs;
  String heroTag = Get.arguments["heroTag"];
  // 视频详情
  Map videoItem = {};
  // 视频类型 默认投稿视频
  SearchType videoType = Get.arguments['videoType'] ?? SearchType.video;
  // 请求返回的视频信息
  late PlayUrlModel data;
  // 是否开始自动播放 存在多p的情况下，第二p需要为true
  RxBool autoPlay = true.obs;
  Box setting = GStorage.setting;

  /// 播放器配置 画质 音质 解码格式
  late VideoQuality currentVideoQa;
  AudioQuality? currentAudioQa;
  late VideoDecodeFormats currentDecodeFormats;

  late VideoItem firstVideo;
  late AudioItem firstAudio;
  late String videoUrl;
  late String audioUrl;
  late Duration defaultST;

  late TabController tabCtr;
  RxList<String> tabs = <String>["简介", "评论"].obs;
  // 封面图的展示
  RxBool isShowCover = true.obs;
  Floating? floating;

  PlPlayerController plPlayerController = PlPlayerController.getInstance();
  late PreferredSizeWidget headerControl;

  @override
  void onInit() {
    super.onInit();
    tabCtr = TabController(length: 2, vsync: this);

    if (Platform.isAndroid) {
      floating = Floating();
    }
    headerControl = HeaderControl(
      controller: plPlayerController,
      videoDetailCtr: this,
      floating: floating,
    );
  }

  Future playerInit(
      {video, audio, seekToTime, duration, bool autoplay = true}) async {
    await plPlayerController.setDataSource(
      DataSource(
        videoSource: video ?? videoUrl,
        audioSource: audio ?? audioUrl,
        type: DataSourceType.network,
        httpHeaders: {
          'user-agent':
              'Mozilla/5.0 (Macintosh; Intel Mac OS X 13_3_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.4 Safari/605.1.15',
          'referer': HttpString.baseUrl
        },
      ),
      duration: duration ?? Duration(milliseconds: data.timeLength ?? 0),
      autoplay: autoplay,
    );

    /// 开启自动全屏时，在player初始化完成后立即传入headerControl
    plPlayerController.headerControl = headerControl;
  }

  // 视频链接
  // 如果 autoplay == true, 会去初始化Player
  Future queryVideoUrl() async {
    var result = await VideoHttp.videoUrl(cid: cid.value, bvid: bvid);
    if (result['status']) {
      data = result['data'];
      List<VideoItem> allVideosList = data.dash!.video!;

      try {
        // 当前可播放的最高质量视频
        int currentHighVideoQa = allVideosList.first.quality!.code;
        // 使用预设的画质 ｜ 当前可用的最高质量
        int cacheVideoQa = setting.get(SettingBoxKey.defaultVideoQa,
            defaultValue: currentHighVideoQa);
        int resVideoQa = currentHighVideoQa;
        if (cacheVideoQa <= currentHighVideoQa) {
          // 如果预设的画质低于当前最高
          List<int> numbers = data.acceptQuality!
              .where((e) => e <= currentHighVideoQa)
              .toList();
          resVideoQa = Utils.findClosestNumber(cacheVideoQa, numbers);
        }
        currentVideoQa = VideoQualityCode.fromCode(resVideoQa)!;

        /// 取出符合当前画质的videoList
        List<VideoItem> videosList =
            allVideosList.where((e) => e.quality!.code == resVideoQa).toList();

        // 优先顺序 设置中指定解码格式 -> 当前可选的首个解码格式
        List<FormatItem> supportFormats = data.supportFormats!;
        // 根据画质选编码格式
        List supportDecodeFormats =
            supportFormats.firstWhere((e) => e.quality == resVideoQa).codecs!;
        // 默认从设置中取AVC
        currentDecodeFormats = VideoDecodeFormatsCode.fromString(setting.get(
            SettingBoxKey.defaultDecode,
            defaultValue: VideoDecodeFormats.values.last.code))!;
        try {
          // 当前视频没有对应格式返回第一个
          bool flag = false;
          for (var i in supportDecodeFormats) {
            if (i.startsWith(currentDecodeFormats.code)) {
              flag = true;
            }
          }
          currentDecodeFormats = flag
              ? currentDecodeFormats
              : VideoDecodeFormatsCode.fromString(supportDecodeFormats.first)!;
        } catch (err) {
          SmartDialog.showToast('DecodeFormats error: $err');
        }

        /// 取出符合当前解码格式的videoItem
        try {
          firstVideo = videosList.firstWhere(
              (e) => e.codecs!.startsWith(currentDecodeFormats.code));
        } catch (_) {
          firstVideo = videosList.first;
        }
        videoUrl = firstVideo.baseUrl!;
      } catch (err) {
        SmartDialog.showToast('firstVideo error: $err');
      }

      /// 优先顺序 设置中指定质量 -> 当前可选的最高质量
      late AudioItem? firstAudio;
      List<AudioItem> audiosList = data.dash!.audio!;

      try {
        int resultAudioQa = setting.get(SettingBoxKey.defaultAudioQa,
            defaultValue: AudioQuality.hiRes.code);
        if (data.dash!.dolby?.audio?.isNotEmpty == true) {
          // 杜比
          audiosList.insert(0, data.dash!.dolby!.audio!.first);
        }

        if (data.dash!.flac?.audio != null) {
          // 无损
          audiosList.insert(0, data.dash!.flac!.audio!);
        }

        if (audiosList.isNotEmpty) {
          List<int> numbers = audiosList.map((map) => map.id!).toList();
          int closestNumber = Utils.findClosestNumber(resultAudioQa, numbers);
          if (!numbers.contains(resultAudioQa) &&
              numbers.any((e) => e > resultAudioQa)) {
            closestNumber = 30280;
          }
          firstAudio = audiosList.firstWhere((e) => e.id == closestNumber);
        } else {
          firstAudio = AudioItem();
        }
      } catch (err) {
        firstAudio = audiosList.isNotEmpty ? audiosList.first : AudioItem();
        SmartDialog.showToast('firstAudio error: $err');
      }

      audioUrl = firstAudio.baseUrl ?? '';
      //
      if (firstAudio.id != null) {
        currentAudioQa = AudioQualityCode.fromCode(firstAudio.id!)!;
      }
      defaultST = Duration(milliseconds: data.lastPlayTime!);
      if (autoPlay.value) {
        await playerInit();
        isShowCover.value = false;
      }
    } else {
      if (result['code'] == -404) {
        isShowCover.value = false;
      }
      SmartDialog.showToast(result['msg'].toString());
    }

    return result;
  }
}
