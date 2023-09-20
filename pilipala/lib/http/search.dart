import 'package:pilipala/http/api.dart';
import 'package:pilipala/http/init.dart';

class SearchHttp {
  static Future ab2c({int? aid, String? bvid}) async {
    Map<String, dynamic> data = {};
    if (aid != null) {
      data['aid'] = aid;
    } else if (bvid != null) {
      data['bvid'] = bvid;
    }
    var res = await Request().get(Api.ab2c, data: {...data});
    return res.data['data'].first['cid'];
  }
}
