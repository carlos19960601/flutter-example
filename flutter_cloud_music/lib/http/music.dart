import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/http/api.dart';
import 'package:flutter_cloud_music/http/init.dart';
import 'package:flutter_cloud_music/models/artists_model.dart';
import 'package:flutter_cloud_music/models/found_model.dart';
import 'package:flutter_cloud_music/models/singer_detail_model.dart';
import 'package:flutter_cloud_music/models/singer_videos_model.dart';
import 'package:flutter_cloud_music/models/song_model.dart';
import 'package:flutter_cloud_music/models/songs_model.dart';
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

  ///获取歌曲详情 多个逗号隔开
  static Future<ApiResponse<List<Song>?>> getSongsInfo(String ids) async {
    var res = await Request().get(Api.songDetail, data: {
      'ids': ids,
    });

    if (res.data['code'] == 0) {
      return ApiResponse(
        status: false,
        message: res.data['message'],
      );
    }

    SongsModel songsModel = SongsModel.fromJson(res.data);
    for (final Song song in songsModel.songs) {
      song.privilege =
          songsModel.privileges.firstWhere((element) => element.id == song.id);
    }

    return ApiResponse(status: true, data: songsModel.songs);
  }

  ///获取歌曲播放地址
  static Future<ApiResponse<String>> getPlayUrl(int id,
      {int br = 320000}) async {
    String url = '';
    final his = box.read('${id}url');
    if (his != null) {}

    var res = await Request().get(Api.songUrl, data: {'id': id});
    if (res.data['code'] == 0) {
      return ApiResponse(
        status: false,
        message: res.data['message'],
      );
    }

    return ApiResponse(status: true, data: url);
  }

  ///获取FM 音乐列表 需要登录
  static Future<ApiResponse<List<Song>?>> getFmMusics() async {
    final response = await Request().get('/personal_fm',
        data: {'timestamp': DateTime.now().millisecondsSinceEpoch});

    return ApiResponse(status: true, data: []);
  }

  static Future<ApiResponse<ArtistsModel>> getArtists(
      int page, String initial, int type, int area) async {
    const limit = 20;
    var res = await Request().get(Api.artistList, data: {
      "limit": limit,
      'offset': limit * page,
      'initial': initial,
      'type': type,
      'area': area
    });

    if (res.data['code'] == 0) {
      return ApiResponse(
        status: false,
        message: res.data['message'],
      );
    }

    return ApiResponse(
      status: true,
      data: ArtistsModel.fromJson(res.data),
    );
  }

  static Future<ApiResponse<SingerDetailModel?>> getSingerInfo(
      String id) async {
    var res = await Request().get(
      Api.artistDetail,
      data: {'id': id, 'timestamp': DateTime.now().millisecondsSinceEpoch},
    );

    if (res.data['code'] == 0) {
      return ApiResponse(
        status: false,
        message: res.data['message'],
      );
    }

    final SingerDetailModel model =
        SingerDetailModel.fromJson(res.data["data"]);
    if (model.user == null) {
      //如果user为空 则获取不到是否关注
      //目前需要单独获取其他接口
      final ApiResponse<Artists?> apiResponse = await getArtistsInfo(id);
      if (apiResponse.status) {
        model.artist.followed = apiResponse.data!.followed;
      }
    } else {
      //是入驻歌手
    }
    return ApiResponse(status: true, data: model);
  }

  ///歌手部分信息
  static Future<ApiResponse<Artists?>> getArtistsInfo(String id) async {
    var res = await Request().get("/artists",
        data: {"id": id, "timestamp": DateTime.now().millisecondsSinceEpoch});

    if (res.data['code'] == 0) {
      return ApiResponse(
        status: false,
        message: res.data['message'],
      );
    }

    return ApiResponse(
        status: true, data: Artists.fromJson(res.data["artist"]));
  }

  ///获取歌手全部视频 包含MV
  static Future<ApiResponse<SingerVideosModel?>> getArtistVideos(
      {required int artistId, required String cursor}) async {
    var res = await Request().get(Api.artistVideo, data: {
      "id": artistId,
      'cursor': cursor,
    });

    if (res.data['code'] == 0) {
      return ApiResponse(
        status: false,
        message: res.data['message'],
      );
    }

    return ApiResponse(
      status: true,
      data: SingerVideosModel.fromJson(res.data["data"]),
    );
  }
}
