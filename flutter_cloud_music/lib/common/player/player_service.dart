import 'package:flutter_cloud_music/models/song_model.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';

class PlayerService extends GetxService {
  static PlayerService get to => Get.find();
  late MusicPlayer player;
  //是否是私人FM
  final isFmPlaying = false.obs;
  //当前播放的歌曲ID
  final RxnInt curPlayId = RxnInt();
  //当前播放的歌曲
  final Rxn<Song> curPlay = Rxn<Song>();
  //播放列表ID
  final queueIdValue = ''.obs;
  //播放列表大小
  final queueSizeValue = 0.obs;
  //播放模式
  final playMode = Rx<PlayMode>(PlayMode.sequence);

  @override
  void onInit() {
    super.onInit();
    player = MusicPlayer();

    player.addListener(() {
      _update();
    });

    player.queueListenable.addListener(() {
      final PlayQueue queue = player.queue;
      if (GetUtils.isNullOrBlank(queue.queueId) != true) {
        final queueMap = queue.toMap();
      }
    });
  }

  void _update() {
    if (curPlay.value == null) {
      if (player.metadata != null) {
        curPlay.value = Song.fromMetadata(player.metadata!);
      } else {
        curPlay.value = null;
      }
    }
    playMode.value = player.playMode;
    queueIdValue.value = player.queue.queueId;
    queueSizeValue.value = player.queue.queue.length;
  }
}
