import 'package:get/get.dart';
import 'package:git_touch/pages/home/view.dart';
import 'package:git_touch/routes/appp_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(name: AppRoutes.login, page: () => const HomePage()),
  ];
}
