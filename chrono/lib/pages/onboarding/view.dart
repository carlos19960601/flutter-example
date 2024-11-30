import 'package:chrono/core/app_extension.dart';
import 'package:chrono/core/app_storage.dart';
import 'package:chrono/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      globalBackgroundColor: context.surface,
      pages: [
        PageViewModel(
          title: "",
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Important",
                style: context.titleMedium?.copyWith(
                  color: context.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Some devices have battery optimizations that prevent background app from functioning properly. This might cause alarms and timers to not go off reliably. Please click the button below and follow the guide to disable these optimizations for your device. You can also do so later by going to Settings > General > Reliability",
                style: context.bodyLarge,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'View Settings',
                  style: TextStyle(color: context.onPrimary),
                ),
              )
            ],
          ),
          decoration: pageDecoration,
        ),
      ],
      showSkipButton: true,
      onDone: () => onIntroEnd(context),
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
    );
  }

  onIntroEnd(BuildContext context) {
    AppStorage().setIsFresh(false);
    Get.offNamed(Routes.main);
  }
}
