import 'package:flutter_cloud_music/common/constants.dart';

class Routes {
  Routes._();

  static const ROUTES_HOST = "$APP_ROUTER_TAG://";

  static const NOT_FOUND = '/not_found';
  static const SPLASH = '/splash';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const PHONE_LOGIN = '/phone_login';
  static const PWD_LOGIN = '/pwd_login';
  static const VER_CODE = '/verification';
  static const EMAIL_LOGIN = '/email_login';
  static const FOUND = '/found';
  static const PODCAST = '/podcast';
  static const MINE = '/mine';
  static const K_SONG = '/k_song';
  static const CLOUD_VILLAGE = '/cloud_cillage';

  //pageLoading
  static const PAGE_MID_LOADING = '/page_mid_loading/:route';
  // 歌单广场
  static const PLAYLIST_COLLECTION = '/playlistCollection';
  //歌单全部标签
  static const PLAYLIST_TAGS = '/playlistTags';
  //歌单详情 id:歌单ID
  static const PLAYLIST_DETAIL = "/playlist/:id";
  //每日推荐
  static const RCMD_SONG_DAY = '/songrcmd';
  //私人FM播放页面
  static const PRIVATE_FM = "/privatefm";
  //播放页面
  static const PLAYING = "/song/:id";
  //html页面
  static const WEB = "/openurl";
  //新歌 新专辑
  static const NEW_SONG_ALBUM = '/nm/discovery/newsongalbum';
  //专辑详情
  static const ALBUM_DETAIL = '/album/:id';
  //音乐日历
  static const MUSIC_CALENDAR = '/nm/musicCalendar/detail';
  //歌手分类列表
  static const SINGER_PAGE = '/singer';
  //歌手详情
  static const SINGER_DETAIL = '/singer/detail';
  //歌单管理
  static const PL_MANAGE = '/plManage';
  //添加歌曲到歌单
  static const ADD_SONG = '/add_song';
  //添加视频到歌单
  static const ADD_VIDEO = '/add_video';
  //单一的搜索（指定搜索类型）
  static const SINGLE_SEARCH = '/single_search';
  //视频页面
  static const VIDEO_PLAY = '/video_play';
  //评论详情
  static const COMMENT_DETAIL = '/comment/detail';
  //search
  static const SEARCH = '/search';
  //排行榜
  static const RANK = '/rnpage';
}
