import 'package:flutter/material.dart';
import 'package:parallax_travel_cards_hero/models/city.dart';

class CityScenery extends StatelessWidget {
  const CityScenery({
    super.key,
    this.animationValue = 0,
    required this.city,
  });

  final City city;
  final double animationValue;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Animation<double> animation = AlwaysStoppedAnimation(animationValue);
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildBackgroundTransition(animation),
        _buildCardInfo(animation, screenSize),
      ],
    );
  }

  Widget _buildBackgroundTransition(Animation<double> animation) {
    var gradientStart =
        ColorTween(begin: city.color, end: const Color(0xFFfde9c8))
            .animate(CurvedAnimation(curve: Curves.easeOut, parent: animation));
    var gradientEnd =
        ColorTween(begin: city.color, end: const Color(0xFFfdf8f1))
            .evaluate(animation);
    var borderRadiusAnimation =
        Tween<double>(begin: 10, end: 0).transform(animationValue);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusAnimation),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [gradientStart.value!, gradientEnd!],
        ),
      ),
    );
  }

  Widget _buildCardInfo(Animation<double> animation, Size screenSize) {
    return FadeTransition(
      opacity: Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(0, 0.22),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(right: 35.0, left: 35.0, bottom: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: screenSize.height * .22),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                city.title,
                style: const TextStyle(
                  height: 1,
                  color: Color(0xFF1a1a1a),
                  fontSize: 25,
                ),
              ),
            ),
            Text(
              city.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF666666),
                height: 1.4,
                fontSize: 12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 12),
              child: Text(
                'Learn More'.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFFa6998b),
                  fontSize: 12,
                  height: 1,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
