import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key, required this.animationController});

  final AnimationController animationController;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            'assets/introduction_animation/introduction_image.png',
            fit: BoxFit.cover,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Text(
            "Clearhead",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 64, right: 64),
          child: Text(
            "Lorem ipsum dolor sit amet,consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore",
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 48,
        ),
      ],
    );
  }
}
