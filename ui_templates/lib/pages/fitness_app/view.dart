import 'package:flutter/material.dart';
import 'package:ui_templates/pages/fitness_app/models/tabIcon_data.dart';
import 'package:ui_templates/pages/fitness_app/theme.dart';

class FitnessAppHomePage extends StatefulWidget {
  const FitnessAppHomePage({super.key});

  @override
  State<FitnessAppHomePage> createState() => _FitnessAppHomePageState();
}

class _FitnessAppHomePageState extends State<FitnessAppHomePage> {
  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  @override
  void initState() {
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiaryScreen(animationController: animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            }

            return const Stack(
              children: [
                tabBody,
              ],
            );
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
