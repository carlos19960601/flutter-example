import 'package:get/get.dart';
import 'package:paisa/middlewares/landig_middleware.dart';
import 'package:paisa/pages/account_selector/view.dart';
import 'package:paisa/pages/category_selector/view.dart';
import 'package:paisa/pages/home/view.dart';
import 'package:paisa/pages/intro/view.dart';
import 'package:paisa/pages/on_boarding/bindings.dart';
import 'package:paisa/pages/on_boarding/view.dart';
import 'package:paisa/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      middlewares: [
        LandingMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.intro,
      page: () => const IntroPage(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const UserOnboardingPage(),
      binding: OnboardingBindings(),
    ),
    GetPage(
      name: AppRoutes.categorySelector,
      page: () => const CategorySelectorPage(),
    ),
    GetPage(
      name: AppRoutes.accountSelector,
      page: () => const AccountSelectorPage(),
    ),

    //   GetPage(name: Routes.PLAYLIST_DETAIL, page: () => PlaylistDetailPage()),
    //   GetPage(
    //     name: Routes.PLAYING,
    //     page: () => const PlayingPage(),
    //     binding: PlayingBinding(),
    //   ),
    //   GetPage(
    //     name: Routes.VIDEO_PLAY,
    //     page: () => const VideoPage(),
    //     binding: VideoBinding(),
    //   ),
    //   //singer detail
    //   GetPage(
    //       name: Routes.SINGER_DETAIL,
    //       page: () => SingerDetailPage(),
    //       preventDuplicates: false,
    //       transition: Transition.rightToLeft),
  ];
}
