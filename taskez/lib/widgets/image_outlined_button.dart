import 'package:flutter/material.dart';
import 'package:taskez/core/app_theme.dart';

class OutlinedButtonWithImage extends StatelessWidget {
  const OutlinedButtonWithImage({
    super.key,
    required this.imageUrl,
    this.width,
  });

  final String imageUrl;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 60,
      child: ElevatedButton(
        style: ButtonStyles.imageRounded,
        onPressed: () {},
        child: Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: ClipOval(
              child: Image(
                image: AssetImage(imageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
