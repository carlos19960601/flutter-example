import 'package:flutter_cloud_music/http/api.dart';
import 'package:flutter_cloud_music/http/init.dart';
import 'package:flutter_cloud_music/models/found_model.dart';

class MusicHttp {
  static Future<ApiResponse<FoundData>> getFoundRec(
      {bool refresh = false, Map<String, dynamic>? cacheData}) async {
    var res = await Request().get(Api.homeFound);

    if (res.data['code'] == 0) {
      return ApiResponse(
        status: false,
        message: res.data['message'],
      );
    }

    return ApiResponse(
      status: true,
      data: FoundData.fromJson(res.data["data"]),
    );
  }
}
