import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planets/models/planet_info.dart';
import 'package:planets/routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9354B9),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0050AC),
              Color(0xFF9354B9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Explore",
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        DropdownButton(
                          items: const [
                            DropdownMenuItem(
                              child: Text(
                                "Solar System",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Color(0x7cdbf1ff),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                          onChanged: (value) {},
                          underline: const SizedBox(),
                          icon: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset("assets/drop_down_icon.png"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Swiper(
                    fade: 0.3,
                    layout: SwiperLayout.STACK,
                    itemCount: planets.length,
                    itemWidth: Get.mediaQuery.size.width - 2 * 32,
                    pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        activeSize: 20,
                        activeColor: Colors.yellow.shade300,
                        space: 5,
                      ),
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.detail,
                            arguments: planets[index],
                          );
                        },
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                const SizedBox(height: 100),
                                Card(
                                  elevation: 8,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(32.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 100),
                                        Text(
                                          planets[index].name.toString(),
                                          style: const TextStyle(
                                            fontSize: 40,
                                            fontFamily: 'Avenir',
                                            color: Color(0xff47455f),
                                            fontWeight: FontWeight.w900,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        const Text(
                                          "Solar System",
                                          style: TextStyle(
                                            fontSize: 23,
                                            fontFamily: 'Avenir',
                                            color:
                                                Color.fromARGB(255, 58, 58, 59),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(top: 32),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Know more",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFFE4979E),
                                                    fontWeight:
                                                        FontWeight.w400),
                                                textAlign: TextAlign.left,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_rounded,
                                                color: Color(0xFFE4979E),
                                                size: 18,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Hero(
                              tag: planets[index].position,
                              child: Image.asset(
                                planets[index].iconImage.toString(),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
