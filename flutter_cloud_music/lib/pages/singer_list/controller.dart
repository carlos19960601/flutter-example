import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/http/api.dart';
import 'package:flutter_cloud_music/http/music.dart';
import 'package:flutter_cloud_music/models/artists_model.dart';
import 'package:flutter_cloud_music/pages/singer_list/model/index_artists.dart';
import 'package:flutter_cloud_music/pages/singer_list/state.dart';
import 'package:get/get.dart';

class SingerListController extends GetxController
    with GetTickerProviderStateMixin {
  final singerListState = SingerListState();
  RxList<IndexArtists> indexArtistsList = RxList<IndexArtists>();

  @override
  void onInit() {
    super.onInit();
    singerListState.scrollController = ScrollController();
  }

  @override
  void onReady() {
    super.onReady();
    getList();
  }

  Future<void> getList() async {
    _resetData();
    _request();
  }

  void _resetData() {
    singerListState.page = 0;
    singerListState.curInitial = singerListState.initials.elementAt(0);
  }

  Future<void> _request() async {
    ApiResponse<ArtistsModel> result = await MusicHttp.getArtists(
      singerListState.page,
      singerListState.curInitial,
      singerListState.type.value.id,
      singerListState.area.value.id,
    );

    if (result.status) {
      indexArtistsList.value = [
        IndexArtists(
            index: singerListState.curInitial, artists: result.data!.artists)
      ];
    }
  }
}
