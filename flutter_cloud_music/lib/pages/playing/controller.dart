import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/models/song_model.dart';
import 'package:get/get.dart';

class PlayingController extends GetxController {
  final Rxn<Song> curPlaying = Rxn<Song>(PlayerService.to.curPlay.value);
  final RxBool showNeedle = false.obs;

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      showNeedle.value = true;
    });
  }
}
