import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskez/core/app_color.dart';

class LabelledFormInput extends StatelessWidget {
  const LabelledFormInput({
    super.key,
    required this.placeholder,
    required this.keyboardType,
    required this.controller,
    required this.obscureText,
    required this.label,
    this.value,
  });

  final String label;
  final String placeholder;
  final String? value;
  final String keyboardType;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          label.toUpperCase(),
          textAlign: TextAlign.left,
          style: GoogleFonts.lato(
            fontSize: 20,
            color: HexColor.fromHex("3C3E49"),
          ),
        ),
        TextFormField(
          controller: controller,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
          onTap: () {},
          keyboardType: keyboardType == "text"
              ? TextInputType.text
              : TextInputType.number,
          obscureText:
              placeholder == 'Password' || placeholder == 'Choose a password'
                  ? true
                  : false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 20,
            ),
            suffixIcon:
                placeholder == "Password" ? const InkWell() : const InkWell(),
            filled: false,
            hintText: placeholder,
            hintStyle: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HexColor.fromHex("3C3E49"),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: HexColor.fromHex("3C3E49"),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: HexColor.fromHex("BEF0B2"),
              ),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
              ),
            ),
          ),
        )
      ],
    );
  }
}
