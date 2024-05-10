import 'package:get/get.dart';
import 'package:harmony_music/pages/home/view.dart';
import 'package:harmony_music/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
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
