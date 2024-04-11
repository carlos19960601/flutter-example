import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskez/core/app_color.dart';
import 'package:taskez/routes/app_routes.dart';
import 'package:taskez/widgets/background_image.dart';
import 'package:taskez/widgets/dark_radial_background.dart';

class OnboardingStart extends StatelessWidget {
  const OnboardingStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DarkRadialBackground(
            color: HexColor.fromHex("#181a1f"),
          ),
          Positioned(
            top: Get.width * 0.7,
            right: 100,
            child: BackgroundImage(
              scale: 1.0,
              image: "assets/man-head.png",
              gradient: [
                HexColor.fromHex("92ECEC"),
                HexColor.fromHex("92ECEC")
              ],
            ),
          ),
          Positioned(
            top: Get.width * 0.50,
            left: Get.width * 0.12,
            child: BackgroundImage(
              scale: 0.5,
              image: "assets/head_cut.png",
              gradient: [
                HexColor.fromHex("FD9871"),
                HexColor.fromHex("F7D092")
              ],
            ),
          ),
          Positioned(
            top: Get.width * 0.30,
            right: 70,
            child: BackgroundImage(
              scale: 0.4,
              image: "assets/girl_smile.png",
              gradient: [
                HexColor.fromHex("#a7b2fd"),
                HexColor.fromHex("#c1a0fd")
              ],
            ),
          ),
          Positioned(
            top: Get.width * 1.3,
            left: Get.width * 0.83,
            child: Transform.rotate(
              angle: -math.pi / 4,
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.onboardingCarousel);
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: HexColor.fromHex("B6FFE5"),
                  ),
                  child: Transform.rotate(
                    angle: math.pi / 4,
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(top: 80, left: 30),
                      child: const Icon(
                        Icons.arrow_forward,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 150,
            left: 40,
            child: SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Task Management ',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        color: HexColor.fromHex("FDA5FF"),
                      ),
                      children: const [
                        TextSpan(
                          text: '🙌',
                        )
                      ],
                    ),
                  ),
                  Text(
                    'Lets create\na space\nfor your workflows.',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 180,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.onboardingCarousel);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          HexColor.fromHex("246CFE"),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(
                              color: HexColor.fromHex("246CFE"),
                            ),
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Get Started',
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
