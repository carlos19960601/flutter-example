import 'package:get/get.dart';
import 'package:paisa/pages/intro/view.dart';

class Routes {
  static final List<GetPage> getPages = [
    GetPage(name: "/intro", page: () => IntroPage()),
  ];
}
