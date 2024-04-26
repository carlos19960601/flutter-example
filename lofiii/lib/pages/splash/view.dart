import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lofiii/core/app_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    goToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: SvgPicture.asset(
              Get.isDarkMode
                  ? "assets/images/lofiii_dark_mode.svg"
                  : "assets/images/lofiii_light_mode.svg",
              fit: BoxFit.contain,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                AppService.appFullVersion,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future goToNextPage() async {
    
  }
}
