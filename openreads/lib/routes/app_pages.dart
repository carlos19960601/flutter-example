import 'package:get/get.dart';
import 'package:openreads/pages/books/view.dart';
import 'package:openreads/routes/app_routes.dart';

class AppPages {
  static AppPages? _instance;

  AppPages._();

  factory AppPages() => _instance ??= AppPages._();

  final routes = [
    GetPage(
      name: AppRoutes().books,
      page: () => const BooksScreen(),
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
