import 'package:flutter_cloud_music/pages/video/controller.dart';
import 'package:get/get.dart';

class VideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VideoController());
  }
}
