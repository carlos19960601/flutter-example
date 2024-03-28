import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_furniture_store_app/core/app_color.dart';
import 'package:office_furniture_store_app/core/app_data.dart';
import 'package:office_furniture_store_app/pages/furniture_list/view.dart';
import 'package:office_furniture_store_app/pages/home/controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OfficeFurnitureController controller =
        Get.put(OfficeFurnitureController());

    const List<Widget> screens = [
      OfficeFurnitureListScreen(),
    ];

    return Scaffold(
      body: Obx(() => screens[controller.currentBottomNavItemIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentBottomNavItemIndex.value,
          unselectedItemColor: Colors.grey,
          fixedColor: AppColor.lightBlack,
          items: AppData.bottomNavigationItems,
          onTap: controller.switchBetweenBottomNavigationItems,
        ),
      ),
    );
  }
}
