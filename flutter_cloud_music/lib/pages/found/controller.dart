import 'package:flutter_cloud_music/http/api.dart';
import 'package:flutter_cloud_music/http/music.dart';
import 'package:flutter_cloud_music/models/found_model.dart';
import 'package:flutter_cloud_music/pages/found/models/default_search_model.dart';
import 'package:get/get.dart';
import 'package:flutter_cloud_music/common/show_types.dart';

class FoundController extends GetxController {
  final Map<String, double> itemHeightFromType = {
    SHOWTYPE_BANNER: 140,
    SHOWTYPE_BALL: 95,
    SHOWTYPE_HOMEPAGE_SLIDE_PLAYLIST: 213,
    SHOWTYPE_HOMEPAGE_NEW_SONG_NEW_ALBUM: 238,
    HOMEPAGE_SLIDE_PODCAST_VOICE_MORE_TAB: 246,
    SHOWTYPE_SLIDE_SINGLE_SONG: 88,
    SHOWTYPE_SHUFFLE_MUSIC_CALENDAR: 206,
    SHOWTYPE_HOMEPAGE_SLIDE_SONGLIST_ALIGN: 245,
    SHOWTYPE_SHUFFLE_MLOG: 245,
    HOMEPAGE_SLIDE_PLAYABLE_MLOG: 245,
    SHOWTYPE_SLIDE_VOICELIST: 220,
    SHOWTYPE_SLIDE_PLAYABLE_DRAGON_BALL: 200,
    SLIDE_PLAYABLE_DRAGON_BALL_MORE_TAB: 200,
    SLIDE_RCMDLIKE_VOICELIST: 220,
    HOMEPAGE_BLOCK_HOT_TOPIC: 191,
    HOMEPAGE_YUNCUN_PRODUCED: 225,
    SLIDE_PLAYABLE_DRAGON_BALL_NEW_BROADCAST: 204,
  };

  final Rxn<DefaultSearchModel> defuleSearch = Rxn<DefaultSearchModel>();
  final Rxn<FoundData> foundData = Rxn();
  //是否滚动
  final RxBool isScrolled = false.obs;
  //是否成功加载完数据
  final isSucLoad = false.obs;

  @override
  void onReady() {
    super.onReady();
    _requestData();
  }

  void _requestData() {
    getFoundRecList();
  }

  Future getFoundRecList({bool refresh = false}) async {
    ApiResponse<FoundData> result = await MusicHttp.getFoundRec();

    if (result.status) {
      foundData.value = result.data!;
      isSucLoad.value = true;
    }

    return result;
  }
}
