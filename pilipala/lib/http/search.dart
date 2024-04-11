import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:pilipala/http/api.dart';
import 'package:pilipala/http/init.dart';
import 'package:pilipala/models/common/search_type.dart';
import 'package:pilipala/models/search/hot.dart';
import 'package:pilipala/models/search/result.dart';
import 'package:pilipala/models/search/suggest.dart';
import 'package:pilipala/utils/storage.dart';

class SearchHttp {
  static Box setting = GStorage.setting;
  static Future hotSearchList() async {
    var res = await Request().get(Api.hotSearchList);
    if (res.data is String) {
      Map<String, dynamic> resultMap = json.decode(res.data);
      if (resultMap['code'] == 0) {
        return {
          'status': true,
          'data': HotSearchModel.fromJson(resultMap),
        };
      }
    } else if (res.data is Map<String, dynamic> && res.data['code'] == 0) {
      return {
        'status': true,
        'data': HotSearchModel.fromJson(res.data),
      };
    }

    return {
      'status': false,
      'data': [],
      'msg': '请求错误 🙅',
    };
  }

  // 获取搜索建议
  static Future searchSuggest({required term}) async {
    var res = await Request().get(Api.serachSuggest,
        data: {'term': term, 'main_ver': 'v1', 'highlight': term});
    if (res.data is String) {
      Map<String, dynamic> resultMap = json.decode(res.data);
      if (resultMap['code'] == 0) {
        if (resultMap['result'] is Map) {
          resultMap['result']['term'] = term;
        }
        return {
          'status': true,
          'data': resultMap['result'] is Map
              ? SearchSuggestModel.fromJson(resultMap['result'])
              : [],
        };
      } else {
        return {
          'status': false,
          'data': [],
          'msg': '请求错误 🙅',
        };
      }
    } else {
      return {
        'status': false,
        'data': [],
        'msg': '请求错误 🙅',
      };
    }
  }

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

  // 分类搜索
  static Future searchByType({
    required SearchType searchType,
    required String keyword,
    required page,
    String? order,
    int? duration,
  }) async {
    var reqData = {
      'search_type': searchType.type,
      'keyword': keyword,
      // 'order_sort': 0,
      // 'user_type': 0,
      'page': page,
      if (order != null) 'order': order,
      if (duration != null) 'duration': duration,
    };
    var res = await Request().get(Api.searchByType, data: reqData);
    if (res.data['code'] == 0 && res.data['data']['numPages'] > 0) {
      Object data;
      try {
        switch (searchType) {
          case SearchType.video:
            List<int> blackMidsList =
                setting.get(SettingBoxKey.blackMidsList, defaultValue: [-1]);
            for (var i in res.data['data']['result']) {
              // 屏蔽推广和拉黑用户
              i['available'] = !blackMidsList.contains(i['mid']);
            }
            data = SearchVideoModel.fromJson(res.data['data']);
            break;
          case SearchType.live_room:
            data = SearchLiveModel.fromJson(res.data['data']);
            break;
          case SearchType.bili_user:
            data = SearchUserModel.fromJson(res.data['data']);
            break;
          case SearchType.media_bangumi:
            data = SearchMBangumiModel.fromJson(res.data['data']);
            break;
          case SearchType.article:
            data = SearchArticleModel.fromJson(res.data['data']);
            break;
        }
        return {
          'status': true,
          'data': data,
        };
      } catch (err) {
        print(err);
      }
    } else {
      return {
        'status': false,
        'data': [],
        'msg': res.data['data'] != null && res.data['data']['numPages'] == 0
            ? '没有相关数据'
            : res.data['message'],
      };
    }
  }
}
