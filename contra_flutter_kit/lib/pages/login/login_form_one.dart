import 'package:contra_flutter_kit/pages/login/contra_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginFormTypeOne extends StatelessWidget {
  const LoginFormTypeOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/logo_mark.svg"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        ContraText(
                          text: "Login",
                          alignment: Alignment.centerLeft,
                        )
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
