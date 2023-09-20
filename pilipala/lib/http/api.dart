class Api {
  // 推荐视频
  static const String recommendListApp =
      'https://app.bilibili.com/x/v2/feed/index';
  static const String recommendList = '/x/web-interface/index/top/feed/rcmd';

  // 热门视频
  static const String hotList = '/x/web-interface/popular';

  // 获取用户信息
  static const String userInfo = "/x/web-interface/nav";

  // 获取当前用户状态
  static const String userStatOwner = '/x/web-interface/nav/stat';

  // github 获取最新版
  static const String latestApp =
      'https://api.github.com/repos/guozhigq/pilipala/releases/latest';

  // 查询视频分P列表 (avid/bvid转cid)
  static const String ab2c = '/x/player/pagelist';

  // 视频流
  // https://github.com/SocialSisterYi/bilibili-API-collect/blob/master/docs/video/videostream_url.md
  static const String videoUrl = '/x/player/playurl';
}
