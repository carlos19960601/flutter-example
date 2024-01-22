import 'package:flutter_cloud_music/http/api.dart';
import 'package:flutter_cloud_music/http/init.dart';
import 'package:flutter_cloud_music/models/found_model.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/models/playlist_detail_model.dart';

class MusicHttp {
  static Future<ApiResponse<FoundData>> getFoundRec(
      {bool refresh = false, Map<String, dynamic>? cacheData}) async {
    var res = await Request().get(Api.homeFound, data: {
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    });

    if (res.data['code'] == 0) {
      return ApiResponse(
        status: false,
        message: res.data['message'],
      );
    }

    final rcmdData = FoundData.fromJson(res.data["data"]);
    // rcmdData.blocks.insert(
    //     1,
    //     Blocks("HOMEPAGE_BALL", SHOWTYPE_BALL, responseBall.data['data'], null,
    //         null, false));

    FoundData diffData = _diffData(rcmdData, null);
    return ApiResponse(
      status: true,
      data: diffData,
    );
  }

  static FoundData _diffData(FoundData rcmdData, FoundData? oldData) {
    return rcmdData;
  }

  ///歌单详情
  static Future<ApiResponse<PlaylistDetailModel>> getPlaylistDetail(
      String id) async {
    var res = await Request().get(Api.playlistDetail, data: {
      'id': id,
      's': '5',
      'timestamp': DateTime.now().millisecondsSinceEpoch
    });

    if (res.data['code'] == 0) {
      return ApiResponse(
        status: false,
        message: res.data['message'],
      );
    }

    PlaylistDetailModel playlistDetailModel =
        PlaylistDetailModel.fromJson(res.data);

    return ApiResponse(
      status: true,
      data: playlistDetailModel,
    );
  }
}
