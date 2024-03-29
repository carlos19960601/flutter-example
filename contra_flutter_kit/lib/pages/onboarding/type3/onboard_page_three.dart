import 'package:contra_flutter_kit/common/constants.dart';
import 'package:contra_flutter_kit/pages/onboarding/onboard_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardPageTypeThree extends StatelessWidget {
  const OnboardPageTypeThree({super.key, required this.data});

  final OnboardData data;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: ColorPanel.flamingo,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: SvgPicture.asset(
                      data.placeHolder,
                      height: 340,
                      width: 310,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, top: 12.0, bottom: 12.0),
                    child: Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 36,
                        color: ColorPanel.athensGray,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 12, bottom: 12),
                    child: Text(
                      data.description,
                      style: const TextStyle(
                        fontSize: 21,
                        color: ColorPanel.athensGray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
