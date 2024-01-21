import 'package:flutter_cloud_music/common/constants.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/models/login_response.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final isLoggedIn = false.obs;

  String? cookie;
  int? userId;

  @override
  void onInit() {
    super.onInit();
    final loginCache = box.read<Map<String, dynamic>>(CACHE_LOGIN_DATA);
    if (loginCache != null) {
      login(LoginResponse.fromJson(loginCache));
    }
  }

  // 登录处理逻辑
  login(LoginResponse loginResponse) {
    
  }
}
