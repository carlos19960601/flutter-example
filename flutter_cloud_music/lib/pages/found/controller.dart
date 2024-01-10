import 'package:flutter_cloud_music/http/api.dart';
import 'package:flutter_cloud_music/http/music.dart';
import 'package:flutter_cloud_music/models/found_model.dart';
import 'package:flutter_cloud_music/pages/found/models/default_search_model.dart';
import 'package:get/get.dart';

class FoundController extends GetxController {
  final Rxn<DefaultSearchModel> defuleSearch = Rxn<DefaultSearchModel>();
  final Rxn<FoundData> foundData = Rxn();

  @override
  void onReady() {
    super.onReady();
    _requestData();
  }

  void _requestData() {
    getFoundRecList();
  }

  Future getFoundRecList({bool refresh = false}) async {
    ApiResponse<FoundData> result = await MusicHttp.getFoundRec();

    if (result.status) {
      foundData.value = result.data!;
    }

    return result;
  }
}
