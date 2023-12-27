import 'dart:developer';

import 'package:flutter/material.dart';

class ParallaxImageCard extends StatelessWidget {
  const ParallaxImageCard({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  BoxDecoration get _perallaxUrlImageDecoration => BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(-7, 7),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter:
              const ColorFilter.mode(Colors.black26, BlendMode.colorBurn),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(decoration: _perallaxUrlImageDecoration),
      ],
    );
  }
}
