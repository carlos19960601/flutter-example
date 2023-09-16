// ignore_for_file: must_be_immutable

import 'package:get/get.dart';
import 'package:pilipala/pages/webview/view.dart';

class Routes {
  static final List<GetPage> getPages = [
    CustomGetPage(
      name: "/webview",
      page: () => const WebviewPage(),
    )
  ];
}

class CustomGetPage extends GetPage {
  bool? fullscreen = false;

  CustomGetPage({
    name,
    page,
    this.fullscreen,
    transitionDuration,
  }) : super(
            name: name,
            page: page,
            fullscreenDialog: fullscreen != null && fullscreen);
}
