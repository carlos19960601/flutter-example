import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;
  late PageController pageController;

  onPageChanged(int value) {
    currentIndex.value = value;
  }

  onDestinationSelected(int value) {
    currentIndex.value = value;
    pageController.jumpToPage(value);
  }
}
