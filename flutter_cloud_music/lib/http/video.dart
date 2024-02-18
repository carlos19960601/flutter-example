import 'package:flutter_cloud_music/common/ext/ext.dart';
import 'package:flutter_cloud_music/common/logger.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/http/init.dart';
import 'package:flutter_cloud_music/models/mv_detail_model.dart';
import 'package:flutter_cloud_music/models/video_count_info.dart';
import 'package:flutter_cloud_music/models/video_detail_model.dart';

class VideoHttp {
  ///获取播放地址
  ///type 0:MV 1:视频 2:MLog
  static Future<String> getVideoPlayUrl(String id) async {
    final cacheUrl = box.read<String>(id);
    if (cacheUrl != null && cacheUrl.isNotEmpty) {
      //有缓存
      final uri = Uri.parse(cacheUrl);
      final createTime = uri.queryParameters['wsTime'];
      if (createTime != null) {
        //当前时间
        final curTime = DateTime.now().millisecondsSinceEpoch;
        //过期时间 一个小时后
        final exceedTime = (double.parse(createTime) + 60 * 60) * 1000;
        if (curTime > exceedTime) {
          //地址已过期
          logger.e(
              '地址已过期 过期时间：${DateTime.fromMillisecondsSinceEpoch(exceedTime.toInt())}');
          box.remove(id);
        } else {
          //没有过期
          logger.i('缓存没有过期 直接使用');
          return cacheUrl;
        }
      }
    }
    String url = '';
    if (id.isMv()) {
      final response = Request().get('/mv/url', data: {'id': id});
      url = response.data['data']['url'].toString();
    } else if (id.isVideo()) {
      url = await _getVideoUrl(id);
    } else if (id.isMLog()) {
      final videoId = await mlogToVideo(id);
      url = await _getVideoUrl(videoId);
    } else {
      toast('未知视频ID类型: $id');
    }
    if (url.isNotEmpty) {
      url = url.toHttps();
    }
    box.write(id, url);
    return url;
  }

  /// 视频/MV/Mlog 点赞转发评论数
  static Future<VideoCountInfo> getVideoCountInfoWithType(String id) async {
    VideoCountInfo info = VideoCountInfo(0, 0, 0);
    if (id.isMv()) {
      final response =
          await Request().get('/mv/detail/info', data: {'mvid': id});
      info = VideoCountInfo.fromJson(response.data);
    } else if (id.isVideo()) {
      info = await _getVideoCountInfo(id);
    } else if (id.isMLog()) {
      final videoId = await mlogToVideo(id);
      info = await _getVideoCountInfo(videoId);
    } else {
      toast('未知视频ID类型: $id');
    }
    return info;
  }

  ///获取视频详情
  static Future<dynamic> getVideoInfo(String id) async {
    if (id.isMv()) {
      final response = await Request().get('/mv/detail', data: {'mvid': id});
      return MvDetailModel.fromJson(response.data['data']);
    } else if (id.isVideo()) {
      return _getVideoInfo(id);
    } else if (id.isMLog()) {
      final videoId = await mlogToVideo(id);
      return _getVideoInfo(videoId);
    } else {
      toast('未知视频ID类型: $id');
    }
  }

  ///获取视频点赞转发评论数
  static Future<VideoCountInfo> _getVideoCountInfo(String id) async {
    VideoCountInfo info = VideoCountInfo(0, 0, 0);
    final response =
        await Request().get('/video/detail/info', data: {'vid': id});
    if (response.isSuccess()) {
      info = VideoCountInfo.fromJson(response.data);
    }
    return info;
  }

  static Future<VideoDetailModel> _getVideoInfo(String id) async {
    final response = await Request().get('/video/detail', data: {'id': id});
    return VideoDetailModel.fromJson(response.data['data']);
  }

  static Future<String> _getVideoUrl(String id) async {
    final response = await Request().get('/video/url', data: {'id': id});
    return (response.data['urls'] as List).first['url'].toString();
  }

  ///通过mlog获取视频ID
  static Future<String> mlogToVideo(String id) async {
    final response = await Request().get('/mlog/to/video', data: {'id': id});
    return response.data['data'].toString();
  }
}
