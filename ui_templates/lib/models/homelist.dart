import 'package:flutter/widgets.dart';
import 'package:ui_templates/pages/design_course/view.dart';
import 'package:ui_templates/pages/fitness_app/view.dart';
import 'package:ui_templates/pages/hotel_booking/view.dart';
import 'package:ui_templates/pages/introduction_animation/view.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/introduction_animation/introduction_animation.png',
      navigateScreen: const IntroductionAnimationPage(),
    ),
    HomeList(
      imagePath: 'assets/hotel/hotel_booking.png',
      navigateScreen: const HotelHomePage(),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/fitness_app.png',
      navigateScreen: const FitnessAppHomePage(),
    ),
    HomeList(
      imagePath: 'assets/design_course/design_course.png',
      navigateScreen: const DesignCourseHomePage(),
    ),
  ];
}
