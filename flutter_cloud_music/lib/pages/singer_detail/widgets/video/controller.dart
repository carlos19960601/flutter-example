import 'package:flutter_cloud_music/http/music.dart';
import 'package:flutter_cloud_music/models/singer_videos_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SingerVideoController extends GetxController {
  SingerVideoController(this.id);

  int id;
  String cursor = '0';
  late RefreshController refreshController;
  Rxn<SingerVideosModel> model = Rxn<SingerVideosModel>();

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController();
  }

  @override
  void onReady() {
    super.onReady();
    refreshData();
  }

  Future<void> refreshData() async {
    cursor = '0';
    _requestData();
  }

  Future<void> loadMore() async {
    cursor = model.value!.page.cursor;
    _requestData();
  }

  Future<void> _requestData() async {
    MusicHttp.getArtistVideos(artistId: id, cursor: cursor).then((response) {
      if (cursor == "0") {
        model.value = response.data;
      } else {
        //加载更多
        final newList = model.value!.records.toList(growable: true);
        newList.addAll(response.data!.records);
        model.value = SingerVideosModel(newList, response.data!.page);
      }
    });
  }
}
