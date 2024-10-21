import 'package:chrono/pages/main/view.dart';
import 'package:chrono/pages/onboarding/view.dart';
import 'package:chrono/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> routes = [
    GetPage(
      name: Routes.onboarding,
      page: () => const OnBoardingPage(),
    ),
    GetPage(
      name: Routes.main,
      page: () => const MainPage(),
    ),
  ];
}
