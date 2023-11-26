import 'package:contra_flutter_kit/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreenPage extends StatelessWidget {
  const WelcomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: ColorPanel.persianBlue,
        child: Column(
          children: [
            AppBar(
              backgroundColor: ColorPanel.persianBlue,
              elevation: 0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: SvgPicture.asset(
                    "assets/icons/logo_mark.svg",
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Welcome To Contra Flutter Kit",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: ColorPanel.selago,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "coded by",
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorPanel.selago,
                    ),
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                          text: "@nathansdev",
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
