import 'package:get/get.dart';
import 'package:planets/pages/detail/view.dart';
import 'package:planets/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: AppRoutes.detail,
      page: () => const DetailPage(),
      transition: Transition.fade,
    ),
  ];
}
