import 'package:flutter_cloud_music/common/show_types.dart';
import 'package:flutter_cloud_music/http/api.dart';
import 'package:flutter_cloud_music/http/init.dart';
import 'package:flutter_cloud_music/models/found_model.dart';

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
}
