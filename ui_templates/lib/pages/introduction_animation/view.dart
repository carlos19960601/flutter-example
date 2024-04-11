import 'package:flutter/material.dart';
import 'package:ui_templates/pages/introduction_animation/widgets/splash_view.dart';

class IntroductionAnimationPage extends StatefulWidget {
  const IntroductionAnimationPage({super.key});

  @override
  State<IntroductionAnimationPage> createState() =>
      _IntroductionAnimationPageState();
}

class _IntroductionAnimationPageState extends State<IntroductionAnimationPage>
    with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      body: Stack(
        children: [
          SplashView(
            animationController: _animationController!,
          ),
        ],
      ),
    );
  }
}
