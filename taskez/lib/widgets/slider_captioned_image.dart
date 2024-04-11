import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SliderCaptionedImage extends StatelessWidget {
  const SliderCaptionedImage({
    super.key,
    required this.index,
    required this.caption,
    required this.imageUrl,
  });

  final int index;
  final String caption;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: Image(
            image: AssetImage(imageUrl),
            fit: BoxFit.contain,
            height: 450,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Text(
            caption,
            style: GoogleFonts.raleway(
                fontWeight: FontWeight.bold, fontSize: 50, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
