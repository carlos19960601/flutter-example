import 'package:hive/hive.dart';
import 'package:pilipala/common/constants.dart';
import 'package:pilipala/http/api.dart';
import 'package:pilipala/http/init.dart';
import 'package:pilipala/models/home/rcmd/result.dart';
import 'package:pilipala/utils/storage.dart';

class VideoHttp {
  static Box localCache = GStorage.localCache;
  static bool enableRcmdDynamic = true;
  static Future rcmdViewList({required int ps, required int freshIdx}) async {}

  static Future rcmdVideoListApp({int? ps, required int freshIdx}) async {
    try {
      var res = await Request().get(Api.recommendListApp, data: {
        "idx": freshIdx,
        'flush': '5',
        'column': '4',
        'device': 'pad',
        'device_type': 0,
        'device_name': 'vivo',
        'pull': freshIdx == 0 ? 'true' : 'false',
        'appkey': Constants.appKey,
        'access_key': localCache
                .get(LocalCacheKey.accessKey, defaultValue: {})['value'] ??
            ''
      });

      if (res.data["code"] == 0) {
        List<RecVideoItemAppModel> list = [];
        for (var i in res.data['data']['items']) {
          // 屏蔽推广和拉黑用户
          if (i['card_goto'] != 'ad_av' &&
              (!enableRcmdDynamic ? i['card_goto'] != 'picture' : true) &&
              (i['args'] != null)) {
            list.add(RecVideoItemAppModel.fromJson(i));
          }
        }
        return {"status": true, "data": list};
      } else {
        return {"status": false, "data": [], "msg": ""};
      }
    } catch (err) {
      return {"status": false, "data": [], "msg": err};
    }
  }
}
