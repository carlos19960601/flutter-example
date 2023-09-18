import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/utils/storage.dart';

class DynamicsController extends GetxController {
  RxBool userLogin = false.obs;

  Box userInfoCache = GStorage.userInfo;
  var userInfo;

  @override
  void onInit() {
    super.onInit();
    userInfo = userInfoCache.get('userInfoCache');
    userLogin.value = userInfo != null;
  }
}
