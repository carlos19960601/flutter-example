import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskez/core/app_color.dart';
import 'package:taskez/routes/app_routes.dart';
import 'package:taskez/widgets/app_logo.dart';
import 'package:taskez/widgets/dark_radial_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.toNamed(Routes.onboardingStart);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DarkRadialBackground(
            color: HexColor.fromHex("#181a1f"),
          ),
          const Positioned(left: 140, child: AppLogo()),
          Center(
            child: Container(
              child: RichText(
                text: TextSpan(
                  text: "Task",
                  style: GoogleFonts.lato(fontSize: 40),
                  children: const [
                    TextSpan(
                      text: "ez",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
