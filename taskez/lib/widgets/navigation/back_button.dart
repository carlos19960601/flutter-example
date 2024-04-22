import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:taskez/widgets/shapes/rounded_border_with_icon.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: const RoundedBorderWithIcon(
        icon: Icons.arrow_back,
      ),
    );
  }
}
