import 'package:cashew/pages/navigation_framework/view.dart';
import 'package:get/get.dart';

class Routes {
  static final List<GetPage> getPages = [
    GetPage(name: "/navigation", page: () => const PageNavigationFramework())
  ];
}
