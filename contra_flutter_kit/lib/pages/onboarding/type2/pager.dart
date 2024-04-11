import 'package:contra_flutter_kit/common/constants.dart';
import 'package:contra_flutter_kit/pages/onboarding/onboard_data.dart';
import 'package:contra_flutter_kit/pages/onboarding/type2/onboard_page_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

class OnboardingPagerTypeTwo extends StatefulWidget {
  const OnboardingPagerTypeTwo({super.key});

  @override
  State<OnboardingPagerTypeTwo> createState() => _OnboardingPagerTypeTwoState();
}

class _OnboardingPagerTypeTwoState extends State<OnboardingPagerTypeTwo> {
  final List<Widget> introWidgetsList = [
    const OnboardPageTypeTwo(
      data: OnboardData(
        placeHolder: "assets/images/onboarding_image_one.svg",
        title: Strings.contraWireframeKit,
        description: Strings.contraWireframeKitPageText,
      ),
    ),
    const OnboardPageTypeTwo(
      data: OnboardData(
          placeHolder: "assets/images/onboarding_image_two.svg",
          title: Strings.contraWireframeKit,
          description: Strings.contraWireframeKitPageText),
    ),
    const OnboardPageTypeTwo(
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
          controller: _pageController,
          itemCount: introWidgetsList.length,
          itemBuilder: (context, index) {
            return introWidgetsList[index];
          },
        ),
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(),
                  GestureDetector(
                    onTap: () {
                      if (currentPageValue < 2) {
                        _pageController.animateToPage(
                          currentPageValue + 1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Get.toNamed("/welcome_screen");
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const ShapeDecoration(
                        color: ColorPanel.lighteningYellow,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: ColorPanel.woodSmoke,
                            width: 2,
                          ),
                        ),
                        shadows: [
                          BoxShadow(
                            color: ColorPanel.woodSmoke,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: SvgPicture.asset("assets/icons/arrow_forward.svg"),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
