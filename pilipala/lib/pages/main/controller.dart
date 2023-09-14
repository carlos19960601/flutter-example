import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  List<Widget> pages = <Widget>[
    const HomePage(),
    const DynamicsPage(),
    const MediaPage(),
  ];
  final navigationBars = [
    {
      "icon": const Icon(
        Icons.favorite_outline,
        size: 21,
      ),
      "selectIcon": const Icon(
        Icons.favorite,
        size: 21,
      ),
      'label': "首页",
    },
    {

    }
  ].obs;

  
}
