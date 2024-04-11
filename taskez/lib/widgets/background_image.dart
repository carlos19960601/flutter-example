import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
    required this.image,
    required this.scale,
    required this.gradient,
  });
  final double scale;
  final String image;
  final List<Color> gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150 * scale,
      height: 150 * scale,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [...gradient],
        ),
      ),
      child: ClipOval(
        child: Image(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
