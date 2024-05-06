import 'package:fitness_app/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key, required this.animationController});

  final AnimationController? animationController;

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            getAppBarUI(),
            SizedBox(
              height: Get.mediaQuery.padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return const Column(
      children: [],
    );
  }
}
