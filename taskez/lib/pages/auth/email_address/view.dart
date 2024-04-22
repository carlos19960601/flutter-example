import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskez/core/app_color.dart';
import 'package:taskez/core/app_theme.dart';
import 'package:taskez/routes/app_routes.dart';
import 'package:taskez/widgets/dark_radial_background.dart';
import 'package:taskez/widgets/forms/form_input_with_label.dart';
import 'package:taskez/widgets/navigation/back.dart';

class EmailAddressScreen extends StatefulWidget {
  const EmailAddressScreen({super.key});

  @override
  State<EmailAddressScreen> createState() => _EmailAddressScreenState();
}

class _EmailAddressScreenState extends State<EmailAddressScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DarkRadialBackground(
            color: HexColor.fromHex("181a1f"),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NavigationBack(),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "What's your\nemail\naddress?",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  LabelledFormInput(
                    placeholder: "Email",
                    keyboardType: "text",
                    controller: _emailController,
                    obscureText: obscureText,
                    label: "Your Email",
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(
                          Routes.signup,
                          parameters: {"email": _emailController.text},
                        );
                      },
                      style: ButtonStyles.blueRounded,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          Text(
                            '   Continue with Email',
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
