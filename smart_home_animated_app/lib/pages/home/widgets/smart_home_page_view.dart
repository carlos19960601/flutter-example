import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_animated_app/common/widgets/room_card.dart';
import 'package:smart_home_animated_app/controller/home_controller.dart';
import 'package:smart_home_animated_app/models/smart_room.dart';

class SmartRoomsPageView extends StatelessWidget {
  const SmartRoomsPageView({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();

    return PageView.builder(
      controller: controller,
      itemCount: SmartRoom.fakeValues.length,
      itemBuilder: (context, index) {
        final room = SmartRoom.fakeValues[index];

        return AnimatedContainer(
          duration: kThemeAnimationDuration,
          curve: Curves.fastOutSlowIn,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RoomCard(
            room: room,
            onSwipeUp: () => homeController.selectRoom.value = index,
            onSwipeDown: () => homeController.selectRoom.value = -1,
            onTap: () {},
          ),
        );
      },
    );
  }
}
