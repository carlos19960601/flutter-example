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
    return IntroductionScreen(
      pages: [
        PageViewModel(
          bodyWidget: Column(
            children: [
              Text(
                "Important",
                style: context.titleMedium,
              ),
              const SizedBox(height: 16),
              Text(
                "Some devices have battery optimizations that prevent background app from functioning properly. This might cause alarms and timers to not go off reliably. Please click the button below and follow the guide to disable these optimizations for your device. You can also do so later by going to Settings > General > Reliability",
                style: context.bodyLarge,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'View Settings',
                  style: TextStyle(color: context.onPrimary),
                ),
              )
            ],
          ),
        ),
      ],
      onDone: () => onIntroEnd(context),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  onIntroEnd(BuildContext context) {
    AppStorage().setIsFresh(false);
    Get.offNamed(Routes.main);
  }
}
