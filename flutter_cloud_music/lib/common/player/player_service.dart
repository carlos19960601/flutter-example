import 'package:get/get.dart';

class PlayerService extends GetxService {
  static PlayerService get to => Get.find();
  //当前播放的歌曲ID
  final RxInt curPlayId = 0.obs;
}
