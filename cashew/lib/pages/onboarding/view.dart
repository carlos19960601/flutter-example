import 'package:cashew/common/constants.dart';
import 'package:cashew/common/widgets/text_font.dart';
import 'package:flutter/material.dart';
import 'package:cashew/localization/translation_keys.dart' as translation_keys;
import 'package:get/get.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnBoardingPageBody(),
    );
  }
}

class OnBoardingPageBody extends StatefulWidget {
  const OnBoardingPageBody({super.key});

  @override
  State<OnBoardingPageBody> createState() => _OnBoardingPageBodyState();
}

class _OnBoardingPageBodyState extends State<OnBoardingPageBody> {
  int currentIndex = 0;
  final PageController controller = PageController();

  final Image imageLanding1 = const Image(
    image: AssetImage("assets/landing/Graph.png"),
  );
  final Image imageLanding2 = const Image(
    image: AssetImage("assets/landing/BankOrPig.png"),
  );
  final Image imageLanding3 = const Image(
    image: AssetImage("assets/landing/PigBank.png"),
  );

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      OnBoardPage(
        widgets: [
          Container(
            child: imageLanding1,
          ),
          const SizedBox(height: 15),
          TextFont(
            text: translation_keys.onboardingTitle1
                .trParams({"app": globalAppName}),
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 15),
          TextFont(text: translation_keys.onboardingInfo1.tr),
          const SizedBox(height: 55),
        ],
      ),
      OnBoardPage(widgets: [
        Container(
          child: imageLanding3,
        ),
        const SizedBox(height: 15),
        TextFont(
          text: translation_keys.onboardingTitle3
              .trParams({"app": globalAppName}),
        ),
        const SizedBox(height: 25),
      ]),
    ];
    return Stack(
      children: [
        PageView(
          controller: controller,
          children: children,
          onPageChanged: (int value) {
            currentIndex = value;
            setState(() {});
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedOpacity(
                  opacity: currentIndex <= 0 ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  child: IconButton(
                    padding: const EdgeInsets.all(3),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.chevron_left_rounded,
                      size: 50,
                    ),
                  ),
                ),
                Row(
                  children: [
                    ...List<int>.generate(children.length, (index) => index)
                        .map((int index) => Builder(
                              builder: (BuildContext contenxt) => AnimatedScale(
                                scale: index == currentIndex ? 1.3 : 1,
                                duration: const Duration(
                                  milliseconds: 900,
                                ),
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  decoration: BoxDecoration(
                                    color: index == currentIndex
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.7)
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ))
                        .toList()
                  ],
                ),
                AnimatedOpacity(
                  opacity: currentIndex == children.length - 1 ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  child: IconButton(
                    padding: const EdgeInsets.all(3),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.chevron_right_rounded,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OnBoardPage extends StatelessWidget {
  const OnBoardPage({super.key, required this.widgets, this.bottomWidget});

  final List<Widget> widgets;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  ...widgets,
                  const SizedBox(height: 80),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
