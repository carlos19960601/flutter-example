class Api {
  // 推荐视频
  static const String recommendListApp =
      'https://app.bilibili.com/x/v2/feed/index';
  static const String recommendList = '/x/web-interface/index/top/feed/rcmd';

  // 获取用户信息
  static const String userInfo = "/x/web-interface/nav";

  // 获取当前用户状态
  static const String userStatOwner = '/x/web-interface/nav/stat';

  // github 获取最新版
  static const String latestApp =
      'https://api.github.com/repos/guozhigq/pilipala/releases/latest';
}
