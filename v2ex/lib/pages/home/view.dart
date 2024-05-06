import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:get/get.dart';
import 'package:v2ex/pages/home/controller.dart';
import 'package:v2ex/pages/home/widgets/left_drawer.dart';
import 'package:v2ex/utils/global.dart';
import 'package:v2ex/widgets/resize_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<bool> stream;
  late final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    stream = _homeController.searchBarStream.stream;
  }

  @override
  Widget build(BuildContext context) {
    num height = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: getBackgroud(context, "homePage"),
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      drawer: Breakpoints.mediumAndUp.isActive(context)
          ? null
          : const HomeLeftDrawer(),
      body: ResizeLayout(
        leftLayout: Column(
          children: [
            CustomAppBar(stream: stream),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.height = kToolbarHeight,
    this.stream,
  });

  final double height;
  final Stream<bool>? stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      initialData: true,
      builder: (context, snapshot) {
        return AnimatedOpacity(
          opacity: snapshot.data ? 1 : 0,
          duration: const Duration(milliseconds: 300),
        );
      },
    );
  }
}
