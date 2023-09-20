import 'package:hive/hive.dart';
import 'package:pilipala/common/constants.dart';
import 'package:pilipala/http/api.dart';
import 'package:pilipala/http/init.dart';
import 'package:pilipala/models/home/rcmd/result.dart';
import 'package:pilipala/models/model_hot_video_item.dart';
import 'package:pilipala/models/video/play/url.dart';
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

  static Future hotVideoList({required int pn, required int ps}) async {
    try {
      var res = await Request().get(Api.hotList, data: {"pn": pn, "ps": ps});
      if (res.data["code"] == 0) {
        List<HotVideoItemModel> list = [];
        for (var i in res.data["data"]["list"]) {
          list.add(HotVideoItemModel.fromJson(i));
        }
        return {"status": true, "data": list};
      } else {
        return {"status": false, "data": []};
      }
    } catch (err) {
      return {"status": false, "data": [], "msg": err};
    }
  }

  // 视频流
  static Future videoUrl(
      {int? avid, String? bvid, required int cid, int? qn}) async {
    Map<String, dynamic> data = {
      // 'avid': avid,
      'bvid': bvid,
      'cid': cid,
      // 'qn': qn ?? 80,
      // 获取所有格式的视频
      'fnval': 4048,
      // 'fnver': '',
      'fourk': 1,
      // 'session': '',
      // 'otype': '',
      // 'type': '',
      // 'platform': '',
      // 'high_quality': ''
    };
    try {
      var res = await Request().get(Api.videoUrl, data: data);
      if (res.data['code'] == 0) {
        return {
          'status': true,
          'data': PlayUrlModel.fromJson(res.data['data'])
        };
      } else {
        return {
          'status': false,
          'data': [],
          'code': res.data['code'],
          'msg': res.data['message'],
        };
      }
    } catch (err) {
      return {'status': false, 'data': [], 'msg': err};
    }
  }
}
