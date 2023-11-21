import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/pages/searchPanel/controller.dart';

class SearchVideoPanel extends StatelessWidget {
  SearchVideoPanel({super.key, this.ctr, this.list});

  final SearchPanelController? ctr;
  final List? list;

  final VideoPanelController controller = Get.put(VideoPanelController());

  @override
  Widget build(BuildContext context) {
    return Stack();
  }
}

class VideoPanelController extends GetxController {}
