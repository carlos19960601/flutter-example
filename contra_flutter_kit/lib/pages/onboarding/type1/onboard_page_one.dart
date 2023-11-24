import 'package:contra_flutter_kit/common/constants.dart';
import 'package:contra_flutter_kit/pages/onboarding/onboard_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardPageTypeOne extends StatelessWidget {
  const OnboardPageTypeOne({super.key, required this.data});

  final OnboardData data;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: SvgPicture.asset(
                      data.placeHolder,
                      height: 320,
                      width: 320,
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
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                    child: Text(
                      data.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 36,
                        color: ColorPanel.woodSmoke,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                    child: Text(
                      data.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 21,
                        color: ColorPanel.trout,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
