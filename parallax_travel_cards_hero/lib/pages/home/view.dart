import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallax_travel_cards_hero/models/city.dart';
import 'package:parallax_travel_cards_hero/pages/home/widgets/city_scenery.dart';
import 'package:parallax_travel_cards_hero/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final City city = demoCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: _buildCityCard(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.only(right: 18 * 3, left: 18 * 3, top: 16),
      child: Text(
        'Get ready for your trip!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildCityCard(context) {
    return Center(
      child: GestureDetector(
        onTap: () => Get.toNamed(
          AppRoutes.cityDetail,
          arguments: {"city": city},
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * .44,
            maxWidth: 300,
          ),
          child: Hero(
            tag: '${city.name}-hero',
            child: CityScenery(city: city),
          ),
        ),
      ),
    );
  }
}
