import 'package:flutter_cloud_music/pages/home/binding.dart';
import 'package:flutter_cloud_music/pages/home/view.dart';
import 'package:flutter_cloud_music/pages/login/view.dart';
import 'package:flutter_cloud_music/pages/playing/binding.dart';
import 'package:flutter_cloud_music/pages/playing/view.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/view.dart';
import 'package:flutter_cloud_music/pages/singer_detail/view.dart';
import 'package:flutter_cloud_music/pages/splash/binding.dart';
import 'package:flutter_cloud_music/pages/splash/view.dart';
import 'package:flutter_cloud_music/pages/video/binding.dart';
import 'package:flutter_cloud_music/pages/video/view.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(name: Routes.LOGIN, page: () => const LoginPage()),
    GetPage(name: Routes.PLAYLIST_DETAIL, page: () => PlaylistDetailPage()),
    GetPage(
      name: Routes.PLAYING,
      page: () => const PlayingPage(),
      binding: PlayingBinding(),
    ),
    GetPage(
      name: Routes.VIDEO_PLAY,
      page: () => const VideoPage(),
      binding: VideoBinding(),
    ),
    //singer detail
    GetPage(
        name: Routes.SINGER_DETAIL,
        page: () => SingerDetailPage(),
        preventDuplicates: false,
        transition: Transition.rightToLeft),
  ];
}
