import 'package:contra_flutter_kit/common/constants.dart';
import 'package:contra_flutter_kit/common/widgets/button_round_with_shadow.dart';
import 'package:contra_flutter_kit/pages/onboarding/onboard_data.dart';
import 'package:contra_flutter_kit/pages/onboarding/type1/onboard_page_one.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class OnboardingPagerTypeOne extends StatefulWidget {
  const OnboardingPagerTypeOne({super.key});

  @override
  State<OnboardingPagerTypeOne> createState() => _OnboardingPagerTypeOneState();
}

class _OnboardingPagerTypeOneState extends State<OnboardingPagerTypeOne> {
  final List<Widget> introWidgetsList = [
    const OnboardPageTypeOne(
      data: OnboardData(
        placeHolder: "assets/images/onboarding_image_one.svg",
        title: Strings.contraWireframeKit,
        description: Strings.contraWireframeKitPageText,
      ),
    ),
    const OnboardPageTypeOne(
      data: OnboardData(
          placeHolder: "assets/images/onboarding_image_two.svg",
          title: Strings.contraWireframeKit,
          description: Strings.contraWireframeKitPageText),
    ),
    const OnboardPageTypeOne(
      data: OnboardData(
          placeHolder: "assets/images/onboarding_image_three.svg",
          title: Strings.contraWireframeKit,
          description: Strings.contraWireframeKitPageText),
    ),
  ];

  int _currentPageValue = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageValue);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          itemBuilder: (context, index) {
            return introWidgetsList[index];
          },
          itemCount: introWidgetsList.length,
          controller: _pageController,
          onPageChanged: (value) {
            _currentPageValue = value;
            setState(() {});
          },
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed("/welcome_screen");
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        side: BorderSide(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPageValue < 2) {
                        _pageController.animateToPage(
                          _currentPageValue + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Get.toNamed("/welcome_screen");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: ColorPanel.woodSmoke,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
        ),
      ],
    );
  }
}
