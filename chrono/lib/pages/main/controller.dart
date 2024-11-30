import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  RxInt currentIndex = 2.obs;
  late PageController pageController;

  @override
  onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentIndex.value);
  }

  onPageChanged(int value) {
    currentIndex.value = value;
  }

  onDestinationSelected(int value) {
    currentIndex.value = value;
    pageController.jumpToPage(value);
  }
}
