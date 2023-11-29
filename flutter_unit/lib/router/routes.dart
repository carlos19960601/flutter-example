import 'package:flutter_unit/pages/navigation/view.dart';
import 'package:get/route_manager.dart';

class Routes {
  static final List<GetPage> getPages = [
    GetPage(name: "/", page: () => const NavigationPage())
  ];
}
