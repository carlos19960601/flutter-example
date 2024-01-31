import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/enums/enum.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/http/api.dart';
import 'package:flutter_cloud_music/http/music.dart';
import 'package:flutter_cloud_music/models/song_model.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/models/playlist_detail_model.dart';
import 'package:get/get.dart';

class PlaylistDetailController extends GetxController {
  String playlistId = ''; //歌单ID
  String autoplay = '0'; //自动播放 0否

  late double expandedHeight;
  //是否是第二次打开官方歌单
  bool secondOpenOfficial = false;
  //歌单详情
  final Rxn<PlaylistDetailModel> detail = Rxn<PlaylistDetailModel>();
  //全部歌曲集合
  final RxList<Song> songs = RxList<Song>();
  final RxInt itemSize = 0.obs;
  //标题状态
  final Rx<PlayListTitleStatus> titleStatus =
      Rx<PlayListTitleStatus>(PlayListTitleStatus.Normal);

  //是否是官方歌单
  final RxBool isOfficial = false.obs;
  //图片
  final Rxn<ImageProvider> coverImage = Rxn<ImageProvider>();

  @override
  void onInit() {
    super.onInit();
    playlistId = Get.parameters['id'] ?? "";
    autoplay = Get.parameters['autoplay'] ?? "";

    secondOpenOfficial = box.read<bool>(playlistId) ?? false;
    expandedHeight = secondOpenOfficial ? Get.height * 0.55 : 256;
  }

  @override
  void onReady() {
    super.onReady();
    _getDetail();
  }

  Future<void> _getDetail({bool showLoading = false}) async {
    final ApiResponse<PlaylistDetailModel> result =
        await MusicHttp.getPlaylistDetail(playlistId);

    if (result.status) {
      PlaylistDetailModel? detailModel = result.data;
      if (detailModel?.isOfficial() == true) {
        //官方歌单
        isOfficial.value = true;
        box.write(playlistId, true);
      }

      if (detailModel?.playlist.specialType == 200) {
      } else {
        await _getTracks(detailModel);
      }
    }
  }

  //音乐歌单
  Future<void> _getTracks(PlaylistDetailModel? detailModel) async {
    List<Song>? result;
    if (detailModel?.playlist.trackIds.length !=
        detailModel?.playlist.tracks.length) {
      //歌曲数量和歌曲ID不一致,请求全部歌曲{id,id}
      //如果ids>1000分批请求
      final idLength = detailModel!.playlist.trackIds.length;
      if (idLength > 1000) {
      } else {
        final ids = detailModel.playlist.trackIds
            .map((e) => e.id.toString())
            .reduce((value, element) => '$value,$element');
        final ApiResponse<List<Song>?> apiResponse =
            await MusicHttp.getSongsInfo(ids);
        result = apiResponse.data;
      }
    } else {
      result = detailModel?.playlist.tracks;
    }

    detail.value = detailModel;
    songs.value = result ?? [];
    itemSize.value = result?.length ?? 0;
  }

  void playAll(BuildContext context) {
    if (detail.value != null) {}
    if (detail.value!.playlist.specialType != 200 && songs.isNotEmpty) {
      
    }
  }
}
