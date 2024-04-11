import 'package:flutter_ui_kit_obkm/pages/page1/view.dart';
import 'package:get/route_manager.dart';

class Routes {
  static final List<GetPage> getPages = [
    GetPage(name: "/pg1", page: () => const Page1()),
  ];
}
