import 'package:flutter_cloud_music/pages/playing/controller.dart';
import 'package:get/get.dart';

class PlayingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlayingController());
  }
}
