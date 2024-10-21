import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallax_travel_cards_hero/models/city.dart';
import 'package:parallax_travel_cards_hero/pages/home/widgets/city_scenery.dart';

class CityDetailScreen extends StatelessWidget {
  CityDetailScreen({super.key});

  final City city = Get.arguments["city"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: _buildHeroWidget(context),
              ),
              _buildCityDetails(),
            ],
          ),
          _buildBackButton(context),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return SafeArea(
      child: IconButton(
        padding: const EdgeInsets.only(left: 18),
        icon: const Icon(Icons.arrow_back_ios, size: 18),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildHeroWidget(context) {
    return Hero(
      tag: '${city.name}-hero',
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .55,
        width: double.infinity,
        child: CityScenery(
          animationValue: 1,
          city: city,
        ),
      ),
    );
  }

  Widget _buildCityDetails() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: <Widget>[
              Text(
                city.title,
                style: const TextStyle(
                  color: Color(0xFF0e0e0e),
                  fontSize: 24,
                  height: 1.2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 18 * 1.5,
                  right: 18 * 1.5,
                ),
                child: Text(city.information,
                    style: const TextStyle(
                      color: Color(0xFF666666),
                      height: 1.4,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center),
              ),
            ],
          ),
          // Cards section
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text('Experiences for every interest'.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              _ExperiencesSection()
            ],
          )
        ],
      ),
    );
  }
}

class _ExperiencesSection extends StatelessWidget {
  final List<String> experiences = ['Arts', 'Food And Drink', 'Classes'];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
        height: screenSize.height * .15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            for (var experience in experiences)
              _buildExperienceCard(screenSize, experience)
          ],
        ));
  }

  Widget _buildExperienceCard(Size screenSize, experience) {
    return Card(
      elevation: 1,
      child: Container(
        color: Colors.white,
        height: screenSize.height * .22,
        width: screenSize.width * .3,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.asset(
                'images/Small-Cards/${experience.replaceAll(' ', '')}.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  experience,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
