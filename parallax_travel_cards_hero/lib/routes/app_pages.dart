import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallax_travel_cards_hero/pages/city_detail/view.dart';
import 'package:parallax_travel_cards_hero/pages/home/view.dart';
import 'package:parallax_travel_cards_hero/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.cityDetail,
      page: () => CityDetailScreen(),
      transitionDuration: const Duration(milliseconds: 1700),
      customTransition: WhitePageRoute(),
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

class WhitePageRoute extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    var fadeIn = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(curve: const Interval(.7, 1), parent: animation));
    var fadeOut = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(curve: const Interval(0, .2), parent: animation));

    return Stack(
      children: [
        FadeTransition(opacity: fadeOut, child: Container(color: Colors.white)),
        FadeTransition(opacity: fadeIn, child: child),
      ],
    );
  }
}
