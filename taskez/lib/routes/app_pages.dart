import 'package:get/get.dart';
import 'package:taskez/pages/onboard/carousel/view.dart';
import 'package:taskez/pages/onboard/start/view.dart';
import 'package:taskez/pages/splash/view.dart';
import 'package:taskez/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.initial,
      page: () => const SplashScreen(),
      // binding: SplashBinding(),
    ),

    GetPage(name: Routes.onboardingStart, page: () => const OnboardingStart()),
    GetPage(
        name: Routes.onboardingCarousel,
        page: () => const OnboardingCarousel()),
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
