import 'package:blackhole/pages/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaavnHomePage extends StatefulWidget {
  const SaavnHomePage({super.key});

  @override
  State<SaavnHomePage> createState() => _SaavnHomePageState();
}

class _SaavnHomePageState extends State<SaavnHomePage> {
  final lists = ["recnet", "playlist"];
  late Future _futureBuilder;
  HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    _futureBuilder = homeController.quertSaavnHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureBuilder,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Obx(() => ListView.builder(
                itemCount: lists.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const Column(
                      children: [
                        
                      ],
                    );
                  }
                  return null;
                }));
          }
          return const SizedBox();
        });
  }
}
