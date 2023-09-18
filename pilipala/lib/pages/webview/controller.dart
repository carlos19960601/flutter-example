import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/http/user.dart';
import 'package:pilipala/pages/home/controller.dart';
import 'package:pilipala/utils/cookie.dart';
import 'package:pilipala/utils/login.dart';
import 'package:pilipala/utils/storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewController extends GetxController {
  String url = '';
  RxString type = ''.obs;
  String pageTitle = "";
  RxInt loadProgress = 0.obs;
  RxBool loadShow = true.obs;
  final WebViewController controller = WebViewController();

  @override
  void onInit() {
    super.onInit();
    url = Get.parameters['url']!;
    type.value = Get.parameters['type']!;
    pageTitle = Get.parameters["pageTitle"]!;

    if (type.value == 'login') {
      controller.clearCache();
      controller.clearLocalStorage();
      WebViewCookieManager().clearCookies();
    }

    webviewInit();
  }

  webviewInit() {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onUrlChange: (UrlChange urlChange) {
          loadShow.value = false;
          String url = urlChange.url ?? "";
          if (type.value == "login" &&
              (url.startsWith(
                      "https://passport.bilibili.com/web/sso/exchange_cookie") ||
                  url.startsWith('https://m.bilibili.com/'))) {
            confirmLogin(url);
          }
        },
        onNavigationRequest: (request) {
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(url));
  }

  confirmLogin(url) async {
    try {
      await SetCookie.onSet();
      var result = await UserHttp.userInfo();
      if (result["status"] && result["data"].isLogin) {
        SmartDialog.showToast("登录成功");
        try {
          Box userInfoCache = GStorage.userInfo;
          await userInfoCache.put("userInfoCache", result["data"]);

          HomeController homeCtr = Get.find<HomeController>();
          homeCtr.updateLoginStatus(true);
          homeCtr.userFace.value = result['data'].face;
          await LoginUtils.refreshLoginStatus(true);
        } catch (err) {
          SmartDialog.show(
            builder: (context) {
              return AlertDialog(
                title: const Text("登录遇到问题"),
                content: Text(err.toString()),
                actions: [
                  TextButton(
                    onPressed: () => controller.reload(),
                    child: const Text('确认'),
                  )
                ],
              );
            },
          );
        }
        Get.back();
      } else {
        SmartDialog.showToast(result.msg);
      }
    } catch (e) {
      SmartDialog.showNotify(msg: e.toString(), notifyType: NotifyType.warning);
    }
  }
}
