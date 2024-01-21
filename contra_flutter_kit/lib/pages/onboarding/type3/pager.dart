import 'package:contra_flutter_kit/common/constants.dart';
import 'package:contra_flutter_kit/common/widgets/button_round_with_shadow.dart';
import 'package:contra_flutter_kit/common/widgets/circle_dot_widget.dart';
import 'package:contra_flutter_kit/pages/onboarding/onboard_data.dart';
import 'package:contra_flutter_kit/pages/onboarding/type3/onboard_page_three.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class OnboardingPagerTypeThree extends StatefulWidget {
  const OnboardingPagerTypeThree({super.key});

  @override
  State<OnboardingPagerTypeThree> createState() =>
      _OnboardingPagerTypeThreeState();
}

class _OnboardingPagerTypeThreeState extends State<OnboardingPagerTypeThree> {
  final List<Widget> introWidgetsList = [
    const OnboardPageTypeThree(
      data: OnboardData(
        placeHolder: "assets/images/onboarding_image_one.svg",
        title: Strings.contraWireframeKit,
        description: Strings.contraWireframeKitPageText,
      ),
    ),
    const OnboardPageTypeThree(
      data: OnboardData(
          placeHolder: "assets/images/onboarding_image_two.svg",
          title: Strings.contraWireframeKit,
          description: Strings.contraWireframeKitPageText),
    ),
    const OnboardPageTypeThree(
      data: OnboardData(
          placeHolder: "assets/images/onboarding_image_three.svg",
          title: Strings.contraWireframeKit,
          description: Strings.contraWireframeKitPageText),
    ),
  ];

  late PageController _pageController;
  int currentPageValue = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPageValue);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          itemCount: introWidgetsList.length,
          itemBuilder: (context, index) {
            return introWidgetsList[index];
          },
          onPageChanged: (int value) {
            currentPageValue = value;
            setState(() {});
          },
        ),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < introWidgetsList.length; i++)
                          CircleDotWidget(
                            isActive: i == currentPageValue,
                            color: i == currentPageValue
                                ? Colors.white
                                : ColorPanel.flamingo,
                            borderColor: Colors.white,
                          )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ButtonTheme(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: ColorPanel.woodSmoke,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 40),
                        ),
                        onPressed: () {
                          Get.toNamed("/welcome_screen");
                        },
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
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
            size: 40,
            callback: () {
              Get.back();
            },
          ),
        )
      ],
    );
  }
}
