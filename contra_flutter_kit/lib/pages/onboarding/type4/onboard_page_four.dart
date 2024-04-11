import 'package:contra_flutter_kit/common/constants.dart';
import 'package:contra_flutter_kit/common/widgets/button_round_with_shadow.dart';
import 'package:contra_flutter_kit/pages/onboarding/onboard_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

class OnboardPageTypeFour extends StatelessWidget {
  const OnboardPageTypeFour({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
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
                            "assets/images/onboarding_image_four.svg",
                            height: 340,
                            width: 310,
                          ),
                        )
                      ],
                    )),
                const Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 24.0, right: 24.0, top: 12.0, bottom: 4.0),
                          child: Text(
                            Strings.openSource,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 21,
                              color: ColorPanel.santasGray,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 24.0, right: 24.0, top: 4.0, bottom: 12.0),
                          child: Text(
                            Strings.contraWireframeKitNextLine,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.w800,
                              color: ColorPanel.woodSmoke,
                            ),
                          ),
                        )
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24.0, top: 8, right: 24),
                          child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed("/welcome_screen");
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(16),
                                backgroundColor: ColorPanel.woodSmoke,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Get Started",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: SvgPicture.asset(
                                        "assets/icons/arrow_next.svg"),
                                  )
                                ],
                              )),
                        )
                      ],
                    )),
              ],
            ),
            Positioned(
              left: 24,
              top: 48,
              child: ButtonRoundWithShadow(
                borderColor: ColorPanel.woodSmoke,
                shadowColor: ColorPanel.woodSmoke,
                color: Colors.white,
                iconPath: "assets/icons/close.svg",
                size: 48,
                callback: () {
                  Get.back();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
