import 'package:fitness_app/core/app_color.dart';
import 'package:fitness_app/models/tabIcon_data.dart';
import 'package:fitness_app/pages/diary/view.dart';
import 'package:fitness_app/widgets/bottom_bar_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  AnimationController? animationController;

  Widget tabBody = Container(
    color: AppColor.background,
  );

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiaryScreen(animationController: animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.background,
      child: Scaffold(
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            }

            return Stack(
              children: [
                tabBody,
                bottomBar(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget bottomBar() {
    return Column(
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
        )
      ],
    );
  }
}
