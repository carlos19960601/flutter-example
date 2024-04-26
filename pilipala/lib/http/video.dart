import 'package:hive/hive.dart';
import 'package:pilipala/common/constants.dart';
import 'package:pilipala/http/api.dart';
import 'package:pilipala/http/init.dart';
import 'package:pilipala/models/home/rcmd/result.dart';
import 'package:pilipala/models/model_hot_video_item.dart';
import 'package:pilipala/models/video/play/url.dart';
import 'package:pilipala/models/video/video_detail_res.dart';
import 'package:pilipala/utils/storage.dart';

class VideoHttp {
  static Box localCache = GStorage.localCache;
  static Box setting = GStorage.setting;
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

  // 视频信息 标题、简介
  static Future videoIntro({required String bvid}) async {
    var res = await Request().get(Api.videoIntro, data: {'bvid': bvid});
    VideoDetailResponse result = VideoDetailResponse.fromJson(res.data);
    if (result.code == 0) {
      return {'status': true, 'data': result.data!};
    } else {
      Map errMap = {
        -400: '请求错误',
        -403: '权限不足',
        -404: '视频资源失效',
        62002: '稿件不可见',
        62004: '稿件审核中',
      };
      return {
        'status': false,
        'data': null,
        'code': result.code,
        'msg': errMap[result.code] ?? '请求异常',
      };
    }
  }

  // 获取点赞状态
  static Future hasLikeVideo({required String bvid}) async {
    var res = await Request().get(Api.hasLikeVideo, data: {'bvid': bvid});
    if (res.data['code'] == 0) {
      return {'status': true, 'data': res.data['data']};
    } else {
      return {'status': false, 'data': []};
    }
  }

  // 获取投币状态
  static Future hasCoinVideo({required String bvid}) async {
    var res = await Request().get(Api.hasCoinVideo, data: {'bvid': bvid});
    if (res.data['code'] == 0) {
      return {'status': true, 'data': res.data['data']};
    } else {
      return {'status': true, 'data': []};
    }
  }

  // 获取收藏状态
  static Future hasFavVideo({required int aid}) async {
    var res = await Request().get(Api.hasFavVideo, data: {'aid': aid});
    if (res.data['code'] == 0) {
      return {'status': true, 'data': res.data['data']};
    } else {
      return {'status': false, 'data': []};
    }
  }

  // 查询是否关注up
  static Future hasFollow({required int mid}) async {
    var res = await Request().get(Api.hasFollow, data: {'fid': mid});
    if (res.data['code'] == 0) {
      return {'status': true, 'data': res.data['data']};
    } else {
      return {'status': true, 'data': []};
    }
  }

  // 相关视频
  static Future relatedVideoList({required String bvid}) async {
    var res = await Request().get(Api.relatedList, data: {'bvid': bvid});
    if (res.data['code'] == 0) {
      List<HotVideoItemModel> list = [];
      for (var i in res.data['data']) {
        list.add(HotVideoItemModel.fromJson(i));
      }
      return {'status': true, 'data': list};
    } else {
      return {'status': false, 'data': []};
    }
  }

  // 视频排行
  static Future getRankVideoList(int rid) async {
    try {
      var rankApi = "${Api.getRankApi}?rid=$rid&type=all";
      var res = await Request().get(rankApi);
      if (res.data["code"] == 0) {
        List<HotVideoItemModel> list = [];
        List<int> blackMidsList =
            setting.get(SettingBoxKey.blackMidsList, defaultValue: [-1]);
        for (var i in res.data['data']['list']) {
          if (!blackMidsList.contains(i['owner']['mid'])) {
            list.add(HotVideoItemModel.fromJson(i));
          }
        }

        return {'status': true, 'data': list};
      } else {
        return {'status': false, 'data': [], 'msg': res.data['message']};
      }
    } catch (err) {
      return {"status": false, "data": [], "msg": err};
    }
  }
}
