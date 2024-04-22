import 'package:flutter/material.dart';
import 'package:ui_templates/pages/introduction_animation/widgets/center_next_button.dart';
import 'package:ui_templates/pages/introduction_animation/widgets/relax_view.dart';
import 'package:ui_templates/pages/introduction_animation/widgets/splash_view.dart';
import 'package:ui_templates/pages/introduction_animation/widgets/top_back_skip_view.dart';

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
    _animationController?.animateTo(0.0);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
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
          RelaxView(
            animationController: _animationController!,
          ),
          TopBackSkipView(
            onBackClick: _onBackClick,
            onSkipClick: _onSkipClick,
            animationController: _animationController!,
          ),
          CenterNextButton(
            animationController: _animationController!,
            onNextClick: _onNextClick,
          ),
        ],
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: const Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 &&
        _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {}
  }
}
