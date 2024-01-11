import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planets/models/planet_info.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final PlanetInfo planetInfo = Get.arguments;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 32),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 300,
                    ),
                    Text(
                      planetInfo.name.toString(),
                      style: const TextStyle(
                        fontSize: 55,
                        color: Color(0xFF414C6B),
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const Text(
                      "Solar System",
                      style: TextStyle(
                          fontSize: 30,
                          color: Color(0xFF414C6B),
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left,
                    ),
                    const Divider(
                      color: Colors.black38,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: -70,
              child: Hero(
                tag: planetInfo.position,
                child: Image.asset(
                  planetInfo.iconImage.toString(),
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 32,
              child: Text(
                planetInfo.position.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 247,
                    color: Colors.grey.withOpacity(0.2)),
              ),
            ),
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
          ],
        ),
      ),
    );
  }
}
