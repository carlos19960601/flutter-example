import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskez/core/app_color.dart';
import 'package:taskez/routes/app_routes.dart';
import 'package:taskez/widgets/dark_radial_background.dart';
import 'package:taskez/widgets/image_outlined_button.dart';
import 'package:taskez/widgets/slider_captioned_image.dart';

class OnboardingCarousel extends StatefulWidget {
  const OnboardingCarousel({super.key});

  @override
  State<OnboardingCarousel> createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final int _numPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: DarkRadialBackground(
              color: HexColor.fromHex("#181a1f"),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: Get.width * 1.3,
                child: PageView(
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  children: const [
                    SliderCaptionedImage(
                      index: 0,
                      imageUrl: "assets/slider-background-1.png",
                      caption: "Task,\nCalendar,\nChat",
                    ),
                    SliderCaptionedImage(
                      index: 1,
                      imageUrl: "assets/slider-background-3.png",
                      caption: "Work\nAnywhere\nEasily",
                    ),
                    SliderCaptionedImage(
                      index: 2,
                      imageUrl: "assets/slider-background-2.png",
                      caption: "Manage\nEverything\nOn Phone",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.onboardingEmailAddress);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                HexColor.fromHex("246CFE"),
                              ),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                    color: HexColor.fromHex("246CFE"),
                                  ),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.email, color: Colors.white),
                                Text(
                                  '   Continue with Email',
                                  style: GoogleFonts.lato(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: OutlinedButtonWithImage(
                                imageUrl: "assets/google_icon.png",
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: OutlinedButtonWithImage(
                                  imageUrl: "assets/facebook_icon.png"),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'By continuing you agree Taskez\'s Terms of Services & Privacy Policy.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              color: HexColor.fromHex("666A7A"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
