import 'package:get/get.dart';
import 'package:resonate/bindings/auth_splash_bindings.dart';
import 'package:resonate/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: AuthSplashBindings(),
    ),
  ];
}
